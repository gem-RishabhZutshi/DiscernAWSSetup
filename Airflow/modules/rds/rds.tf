resource "aws_db_subnet_group" "airflow_subnet_group" {
  name       = "${var.project_name}-${var.stage}"
  subnet_ids = [var.public_subnet_one, var.public_subnet_two]

  tags = {
    Name = "${var.project_name}-${var.stage}-subnet-group"
  }
}

resource "aws_db_instance" "metadata_db" {
  identifier = "${var.project_name}-${var.stage}-postgres"

  # database name
  db_name                = var.project_name
  instance_class         = var.metadata_db_instance_type
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.7"
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.airflow_subnet_group.id
  vpc_security_group_ids = [aws_security_group.airflow_postgres_sg.id]
  username               = var.project_name
  password               = "Airflow2021"
  storage_encrypted      = true

  tags = {
    Name = "${var.project_name}-${var.stage}-postgres"
  }
}
