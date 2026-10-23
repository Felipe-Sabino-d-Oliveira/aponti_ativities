FROM ubuntu:24.04

RUN apt update && apt install -y python3

WORKDIR /my_app_py_docker

COPY app.py .

EXPOSE 5000

CMD ["python3", "app.py"]

# Fazer o build da imagem com o comando:
# docker build . -t seuusuario/meu_app_python:1.0

# Login no Docker Hub com o comando:
# docker login -u seuusuario

# Fazer o push da imagem para o Docker Hub com o comando:
# docker push seuusuario/meu_app_python:1.0

# Depois, procurar:
# https://hub.docker.com/r/seuusuario/meu_app_python
