output "rds_host" {
  value = aws_db_instance.metadata_db.address
}

output "rds_instance" {
  value = aws_db_instance.metadata_db
}