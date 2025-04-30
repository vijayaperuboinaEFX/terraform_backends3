provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/Users/chenc/.aws/credentials"]
}
resource "aws_instance" "practice" {
  ami =  "ami-0f9de6e2d2f067fca" 
  subnet_id = "subnet-07b05c0d562c70b4d"
  instance_type = "t2.micro"
  key_name = "c-laptopkey"
                  
  vpc_security_group_ids = [aws_security_group.sg_web.id]
    tags = {
      Name = "vijay-instance" # Name for the EC2 instances
    }

}
terraform {
    backend "s3" {
        bucket = "vijay-terraform-s3-bucket"
        key    = "vijay/terraform/remote/s3/terraform.tfstate"
        region     = "us-east-1"

    }
}
resource "aws_security_group" "sg_web" {
  vpc_id      = "vpc-06cc6eecc2ae735ba"
  name = "sg_terraform"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




