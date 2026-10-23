# Fluxos de comunicação — Arquitetura Cloud Segura AWS

> Proposta de referência. Ajustar portas e destinos ao framework, ao mecanismo de banco e aos requisitos reais.

| Origem | Destino | Protocolo / porta | Permissão | Finalidade / controle |
|---|---|---:|---|---|
| Clientes na Internet | CloudFront | HTTPS / TCP 443 | Permitir | Acesso externo cifrado; certificado TLS válido. |
| CloudFront | AWS WAF | Integração gerenciada | Associado | Inspeção de requisições e regras de proteção web; não é um salto de rede separado. |
| CloudFront | ALB público | HTTPS / TCP 443 | Permitir somente da distribuição autorizada | Origem protegida; restringir o ALB com controles de origem e Security Group apropriados. |
| ALB | API (ECS/Fargate) | HTTP interno / TCP 8080 (exemplo) | Permitir | SG da API aceita somente do SG do ALB. Preferir TLS também no trecho interno quando o risco/requisito justificar. |
| API | RDS MySQL | TCP 3306 | Permitir, se MySQL | SG do banco aceita somente do SG da API. Sem acesso público. |
| API | RDS PostgreSQL | TCP 5432 | Permitir, se PostgreSQL | Alternativa ao MySQL; escolher apenas a porta do mecanismo utilizado. |
| API (Task Role) | S3 via Gateway VPC Endpoint | HTTPS / TCP 443 | Permitir | Upload/download de objetos; bucket privado, política restrita e IAM limitado ao bucket/prefixo necessário. |
| API | Secrets Manager | HTTPS / TCP 443 | Permitir via conectividade de saída autorizada | Buscar segredos específicos. Pode-se criar interface VPC endpoint para evitar saída via NAT. |
| API | CloudWatch Logs | HTTPS / TCP 443 | Permitir via endpoint ou saída controlada | Envio de logs e métricas. Criar endpoints privados quando apropriado. |
| Administrador | AWS Client VPN | VPN/TLS conforme configuração | Permitir com autenticação e MFA | Entrada administrativa autenticada; não expor serviços internos diretamente. |
| Client VPN | Recursos internos autorizados | Somente portas de administração necessárias | Permitir por grupo/rota/SG | Restringir a destinos e portas explicitamente autorizados; registrar sessões. |
| Serviços AWS / conta | CloudTrail, CloudWatch, GuardDuty | Integrações gerenciadas / HTTPS quando aplicável | Permitir | Auditoria, logs, alertas e detecção de ameaças. |
| API | NAT Gateway | Saída TCP 443, quando necessária | Permitir de forma controlada | Atualizações ou APIs externas; não permite conexões iniciadas da Internet para a API. Preferir endpoints quando disponíveis. |
| Internet | API diretamente | Qualquer | **Bloquear** | API não tem IP público; SG permite somente tráfego do ALB e acessos administrativos específicos. |
| Internet | RDS | Qualquer | **Bloquear** | Banco privado, sem IP público; nenhuma regra SQL aberta para a Internet. |
| Internet | Bucket S3 | HTTP/HTTPS público | **Bloquear** | Bloqueio de acesso público; acesso apenas por IAM/política autorizada. |
| Qualquer origem não autorizada | ALB, API, RDS ou VPN | Qualquer porta não listada | **Bloquear** | Negação por padrão e regras explícitas de Security Groups/rotas. |
| API | RDS em porta diferente da escolhida | TCP não autorizado | **Bloquear** | Reduzir movimento lateral e exposição desnecessária. |
| Usuários comuns | Plano de administração / recursos internos | Portas administrativas | **Bloquear** | Acesso administrativo somente por identidades e grupos autorizados. |

## Observações importantes

- Security Groups são stateful: o tráfego de resposta de uma conexão permitida é aceito automaticamente.
- O AWS WAF é associado ao CloudFront (ou ao ALB, conforme o desenho). Ele não deve ser representado como um firewall de rede genérico entre quaisquer duas sub-redes.
- O S3 Gateway VPC Endpoint é um recurso de rota para S3; não é uma instância dentro da sub-rede. A política de endpoint/bucket e a IAM Role devem limitar os recursos acessíveis.
- CloudTrail, CloudWatch e GuardDuty têm modelos de integração próprios. No diagrama, linhas tracejadas representam telemetria/integrações lógicas, não necessariamente uma conexão direta entre cada serviço.
- Não usar `0.0.0.0/0` como origem para SSH/RDP ou para a porta do banco.
