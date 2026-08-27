# Este é o arquivo de outputs.tf, que define as saídas do Terraform para o projeto prática_terraform

output "bucket_name" {
    description = "O nome do bucket S3 criado"
    value       = var.bucket_name
}

output "id_do_bucket" {
    description = "O ID do bucket S3 criado"
    value       = aws_s3_bucket.meu_bucket.id
}

output "data_information" {
    value = data.aws_s3_bucket.meu_data
}

output "aws_availability_zones" {
    description = "Lista de zonas de disponibilidade da AWS"
    value       = data.aws_availability_zones.available
}