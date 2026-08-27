# Prática com Terraform e AWS

## Descrição da atividade

Esta atividade teve como objetivo praticar o uso do **Terraform** para provisionar e gerenciar recursos na **AWS Cloud**.

Durante a prática, foi realizada a configuração do provedor AWS, a criação de um bucket S3, a utilização de variáveis para tornar o código reutilizável, a consulta de informações por meio de *data sources* e a exibição de informações utilizando *outputs*.

---

## Tecnologias utilizadas

* Terraform
* AWS (Amazon Web Services)
* AWS S3
* Terraform Provider AWS

---

## Estrutura do projeto

O projeto foi organizado em diferentes arquivos para separar as responsabilidades:

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── data.tf
└── terraform.tfvars
```

### `main.tf`

Este arquivo é responsável pela configuração do provedor AWS e pela criação do recurso principal da atividade.

```hcl
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "meu_bucket" {
  bucket = var.bucket_name
}
```

A região e o nome do bucket não foram definidos diretamente no código principal. Em vez disso, foram utilizados valores provenientes de variáveis.

---

## Processo de conexão com a Cloud

A conexão com a AWS é realizada por meio do **AWS Provider**, utilizado pelo Terraform para se comunicar com os serviços da nuvem.

O processo pode ser resumido nas seguintes etapas:

1. Instalação do Terraform na máquina local.
2. Configuração das credenciais de acesso à AWS.
3. Definição do provider AWS no arquivo `main.tf`.
4. Escolha da região onde os recursos serão provisionados.
5. Inicialização do projeto com:

```bash
terraform init
```

Esse comando baixa e configura os provedores necessários para o funcionamento do projeto.

Em seguida, é possível validar a configuração utilizando:

```bash
terraform validate
```

Para visualizar as alterações que serão realizadas na infraestrutura:

```bash
terraform plan
```

Por fim, os recursos podem ser provisionados utilizando:

```bash
terraform apply
```

Após a confirmação da operação, o Terraform se conecta à AWS utilizando as credenciais configuradas e cria o bucket S3 na região definida.

---

## Variáveis

O arquivo `variables.tf` foi utilizado para definir valores reutilizáveis no projeto.

A variável `region` define a região da AWS:

```hcl
variable "region" {
  description = "A região da AWS onde os recursos serão provisionados"
  type        = string
  default     = "sa-east-1"
  nullable    = false

  validation {
    condition = contains(
      ["sa-east-1", "us-east-1", "eu-west-1"],
      var.region
    )

    error_message = "Valor fora das opções disponíveis."
  }
}
```

Além de possuir um valor padrão, essa variável contém uma validação que permite apenas algumas regiões específicas.

Também foi criada a variável `bucket_name`, responsável por definir o nome do bucket S3:

```hcl
variable "bucket_name" {
  description = "O nome do bucket S3 a ser criado"
  type        = string
  default     = "meu-bucket"
}
```

---

## Arquivo `terraform.tfvars`

O arquivo `terraform.tfvars` permite definir valores para as variáveis sem precisar alterar diretamente os arquivos principais do Terraform.

Nesta atividade, foram definidos os seguintes valores:

```hcl
region = "us-east-1"

bucket_name = "meu-bucket"
```

Dessa forma, a infraestrutura será provisionada na região `us-east-1`, substituindo o valor padrão definido em `variables.tf`.

---

## Data Sources

Os *Data Sources* permitem consultar informações sobre recursos existentes na AWS.

Na atividade, foram utilizados exemplos para consultar um bucket S3 e as zonas de disponibilidade:

```hcl
data "aws_s3_bucket" "bucket_existente" {
  bucket = aws_s3_bucket.meu_bucket.bucket
}

data "aws_availability_zones" "disponiveis" {
  state = "available"
}
```

Com isso, é possível acessar informações sobre recursos e serviços da AWS sem necessariamente criar novos recursos.

---

## Outputs

O arquivo `outputs.tf` foi utilizado para exibir informações após a execução do Terraform.

Entre as informações apresentadas estão:

* Nome do bucket criado;
* ID do bucket;
* Informações consultadas por *Data Sources*;
* Zonas de disponibilidade da AWS.

Exemplo:

```hcl
output "bucket_name" {
  description = "O nome do bucket S3 criado"
  value       = var.bucket_name
}

output "id_do_bucket" {
  description = "O ID do bucket S3 criado"
  value       = aws_s3_bucket.meu_bucket.id
}
```

Após executar o `terraform apply`, os valores definidos nos outputs podem ser visualizados no terminal.

---

## Principais aprendizados

Durante a realização da atividade, foi possível aprender e praticar os seguintes conceitos:

### Infraestrutura como Código (IaC)

O Terraform permite definir a infraestrutura utilizando código, facilitando a criação, reprodução e manutenção de recursos em ambientes de nuvem.

### Uso de Providers

O provider AWS é responsável por permitir que o Terraform se comunique com a AWS e gerencie seus recursos.

### Criação de recursos

Foi realizada a definição de um recurso do tipo `aws_s3_bucket`, permitindo criar um bucket na AWS de forma automatizada.

### Uso de variáveis

As variáveis tornam o código mais reutilizável e flexível, permitindo alterar configurações como região e nome do bucket sem modificar diretamente os recursos.

### Validação de dados

A validação aplicada à variável `region` demonstra como o Terraform pode restringir valores inválidos antes do provisionamento.

### Uso do arquivo `.tfvars`

O arquivo `terraform.tfvars` permite separar valores de configuração do código principal, facilitando a reutilização do mesmo projeto em diferentes ambientes.

### Data Sources

Os *Data Sources* permitem consultar informações da infraestrutura existente e utilizar esses dados dentro da configuração do Terraform.

### Outputs

Os outputs facilitam a visualização de informações importantes sobre os recursos criados após o provisionamento.

---

## Comandos utilizados

Inicializar o projeto:

```bash
terraform init
```

Validar os arquivos de configuração:

```bash
terraform validate
```

Visualizar o plano de execução:

```bash
terraform plan
```

Provisionar a infraestrutura:

```bash
terraform apply
```

Visualizar os outputs:

```bash
terraform output
```

Remover os recursos criados:

```bash
terraform destroy
```

---

## Conclusão

A atividade permitiu compreender, na prática, como utilizar o Terraform para realizar o provisionamento de infraestrutura na AWS.

Foram aplicados conceitos importantes como **providers, resources, variables, validações, arquivos `.tfvars`, data sources e outputs**. Além disso, a prática demonstrou como a Infraestrutura como Código pode facilitar a criação e o gerenciamento de recursos em ambientes de Cloud Computing.

Como resultado, foi possível entender o fluxo básico de conexão entre o Terraform e a AWS, desde a configuração do provider e das credenciais até o provisionamento e a consulta das informações dos recursos criados.
