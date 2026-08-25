# Este é um arquivo de configuração do Terraform para provisionar recursos na AWS

# Sintaxe padrão do Terraform

# bloco "tipo" "nome" {
#   argumento = valor
# }

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleInstance"
  }
}