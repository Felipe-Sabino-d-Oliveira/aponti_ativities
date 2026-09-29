# ------------------------------------------------------------
# FROM - Imagem usada como ponto de partida (ex: python, ubuntu, alpine)
# ------------------------------------------------------------
FROM python:3.12-slim
# ------------------------------------------------------------

# LABEL - Adiciona metadados / informações sobre a imagem;
# Servem para identificar e organizar melhor as imagens Docker.
# ------------------------------------------------------------
LABEL maintainer="Exemplo de atividade"
LABEL description="Dockerfile educativo com os principais comandos"
# ------------------------------------------------------------

# ENV - Cria variáveis de ambiente dentro do container.
# ------------------------------------------------------------
ENV APP_ENV=production 
# Aqui estamos informando que a aplicação está em produção.
# ------------------------------------------------------------

# WORKDIR - Define a pasta de trabalho dentro do container.
# ------------------------------------------------------------
WORKDIR /app
# ------------------------------------------------------------
# COPY - Copia arquivos da máquina para dentro da imagem.
# ------------------------------------------------------------
COPY . /app
# ------------------------------------------------------------

# ADD - Também pode copiar arquivos para dentro da imagem,
# possui recursos extras (como trabalhar com URLs e arquivos compactados).
# ------------------------------------------------------------

# OBSERVAÇÃO:
# Normalmente, apenas para copiar arquivos, o
# usa-se COPY por ser mais simples.

ADD exemplo.txt /app/exemplo.txt
# ------------------------------------------------------------

# RUN - Executa um comando durante a criação da imagem.
# ------------------------------------------------------------
RUN pip install --no-cache-dir -r requirements.txt
# ------------------------------------------------------------

# EXPOSE - qual porta a aplicação pretende utilizar.
# ------------------------------------------------------------
# IMPORTANTE:
# EXPOSE não publica a porta sozinho.
# Para acessar a aplicação pelo computador, normalmente
# usa-se algo como:

# docker run -p 8000:8000 nome-da-imagem

EXPOSE 8000
# ------------------------------------------------------------

# VOLUME: 
# Indica uma pasta que pode ser usada para armazenar
# dados que precisam continuar existindo mesmo quando
# o container for recriado.

# É útil para dados que não queremos perder junto com
# o container.

VOLUME ["/app/dados"]
# ------------------------------------------------------------

# ENTRYPOINT - Define o programa principal executado durante o início do container.
# ------------------------------------------------------------
ENTRYPOINT ["python"]
# ------------------------------------------------------------

# CMD - Define comandos / argumentos padrão usados quando o container iniciar.
# ------------------------------------------------------------

# Uma diferença importante:
# ENTRYPOINT define o programa principal, CMD
# fornece os argumentos/comando padrão.
#

# Se quisermos, podemos substituir o CMD ao executar
# o container.

CMD ["app.py"]