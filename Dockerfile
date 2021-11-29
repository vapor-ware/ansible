FROM docker.io/vaporio/python:3.9-slim

ADD requirements.txt .

RUN \
    pip install -r requirements.txt && \
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install community.docker
RUN apt-get update && \
    apt-get install -y openssh-client \
                       git \
                       && \
    rm -rf /var/apt/cache
