resource "aws_instance" "wordpress" {
  ami                         = "ami-0f5ee92e2d63afc18"
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.wordpress_sg.id]
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user-data/wordpress.sh", {
    domain_name = var.domain_name
  })

  tags = {
    Name = "wordpress-server-STAGE"
  }
}