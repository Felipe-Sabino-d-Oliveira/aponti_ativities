# Este é um arquivo de configuração do Terraform para provisionar recursos na AWS

# Sintaxe padrão do Terraform

# bloco "tipo" "nome" {
#   argumento = valor
# }

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = var.bucket_name
}