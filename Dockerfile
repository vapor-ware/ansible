FROM docker.io/vaporio/python:3.9-slim

ENV SCTL_VERSION=1.5.0
ENV GOOGLE_APPLICATION_CREDENTIALS=/localhost/.config/gcloud/application_default_credentials.json

ADD requirements.txt .

# Add Sctl
ADD https://github.com/vapor-ware/sctl/releases/download/${SCTL_VERSION}/sctl_${SCTL_VERSION}_Linux_x86_64.tar.gz /tmp


RUN \
    pip install -r requirements.txt && \
    ansible-galaxy collection install community.general && \
    ansible-galaxy collection install community.docker && \
    ansible-galaxy collection install netbox.netbox
RUN apt-get update && \
    apt-get install -y openssh-client \
                       git \
                       sshpass \
                       curl \
                       && \
    rm -rf /var/apt/cache && \
    mkdir /root/.ssh

RUN curl -LO https://github.com/rancher/cli/releases/download/v2.7.0/rancher-linux-amd64-v2.7.0.tar.gz && \
    tar -zxvf rancher-linux-amd64-v2.7.0.tar.gz && \
    mv /rancher-v2.7.0/rancher /bin/rancher && mkdir ~/.rancher

WORKDIR /tmp

RUN tar xzvf sctl_${SCTL_VERSION}_Linux_x86_64.tar.gz  \
    && install sctl /usr/bin/sctl

WORKDIR /
