exec > /var/log/user-data.log 2>&1
set -eux

echo "=== USER DATA STARTED ==="

apt-get update -y

DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apache2 \
  mysql-server \
  php \
  php-mysql \
  php-cli \
  php-curl \
  php-gd \
  php-mbstring \
  php-xml \
  php-zip \
  curl \
  unzip

systemctl enable apache2
systemctl start apache2

systemctl enable mysql
systemctl start mysql

mysql <<MYSQL
CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Admin@123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL

cd /tmp
curl -fsSL https://wordpress.org/latest.tar.gz -o wp.tar.gz
tar -xzf wp.tar.gz
mv wordpress /var/www/html/wordpress

chown -R www-data:www-data /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

cat >/etc/apache2/sites-available/wordpress.conf <<APACHE
<VirtualHost *:80>
    ServerName your-domain.com
    ServerAlias www.your-domain.com
    DocumentRoot /var/www/html/wordpress

    <Directory /var/www/html/wordpress>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/apache2/wp_error.log
    CustomLog /var/log/apache2/wp_access.log combined
</VirtualHost>
APACHE

a2ensite wordpress.conf
a2enmod rewrite
systemctl reload apache2

cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i "s/database_name_here/wordpress/" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/wpuser/" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/Admin@123/" /var/www/html/wordpress/wp-config.php


echo "=== USER DATA COMPLETED SUCCESSFULLY ==="