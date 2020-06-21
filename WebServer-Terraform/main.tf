resource “aws_security_group” “websg” {
 name =”terraform-webserver-websg”
 ingress{
 from_port = “${var.server_port}”
 to_port = “${var.server_port}”
 protocol =”tcp”
 cidr_blocks = [“0.0.0.0/0”]
 }
}
resource “aws_instance” “webserver”{
 ami = “ami-40d28157”
 instance_type = “t2.micro”
 vpc_security_group_ids = [“${aws_security_group.websg.id}”]

 tags{
 Name = “terraform-first-example”
 }

 user_data = <<-EOF
 #!/bin/bash
 echo “Hello,World” > index.html
 nohup busybox httpd -f -p “${var.server_port}” &
 EOF
}

variable “server_port” {
 description = “The port the server will use for HTTP requests”
 default = 8080
}