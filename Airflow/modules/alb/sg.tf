resource "aws_security_group" "application_load_balancer" {
  name        = "${var.project_name}-${var.stage}-alb-web-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["112.196.66.50/32"]
    description = "gemini VPN"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["34.195.138.142/32"]
    description = "Discern VPN"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["112.196.66.50/32"]
    description = "gemini VPN"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["34.195.138.142/32"]
    description = "Discern VPN"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-alb-web-sg"
  }
}


resource "aws_security_group" "web_server_ecs_internal" {
  name        = "${var.project_name}-${var.stage}-web-server-ecs-internal-sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.application_load_balancer.id]
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-web-server-ecs-internal-sg"
  }
}

resource "aws_security_group" "workers" {
  name        = "${var.project_name}-${var.stage}-workers-sg"
  description = "Airflow Celery Workers security group"
  vpc_id      = var.vpc

  ingress {
    from_port   = 8793
    to_port     = 8793
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-workers-sg"
  }
}

resource "aws_security_group" "scheduler" {
  name        = "${var.project_name}-${var.stage}-scheduler-sg"
  description = "Airflow scheduler security group"
  vpc_id      = var.vpc

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-scheduler-sg"
  }
}

resource "aws_security_group" "flower" {
  name        = "${var.project_name}-${var.stage}-flower-sg"
  description = "Allow all inbound traffic for Flower"
  vpc_id      = var.vpc

  ingress {
    from_port   = 5555
    to_port     = 5555
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.stage}-flower-sg"
  }
}






