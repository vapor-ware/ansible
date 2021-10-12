FROM vaporio/python:3.9-slim

RUN \
    pip install ansible==4.6.0 && \
    ansible-galaxy collection install community.general
RUN apt-get update && apt-get install -y openssh-client && rm -rf /var/apt/cache
