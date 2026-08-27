# Este é o arquivo de variáveis do Terraform para definir valores reutilizáveis

variable "region" {
    description = "A região da AWS onde os recursos serão provisionados"
    type        = string
    default     = "sa-east-1"
		nullable		= false
		validation {
			condition     = contains(["sa-east-1", "us-east-1", "eu-west-1"], var.region)
			error_message = "Valor fora das opções disponíveis."
		}
}

variable "bucket_name" {
    description = "O nome do bucket S3 a ser criado"
    type        = string
    default     = "meu-bucket"
}