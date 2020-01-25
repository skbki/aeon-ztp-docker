FROM ubuntu:16.04
LABEL maintainer="skbki"

RUN apt-get update && apt-get install -y --no-install-recommends ansible git openssh-client

RUN mkdir -p /root/.ssh/ && \
    ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys && \
    chmod -R 600 /root/.ssh/ && \
    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
    
RUN pip install --upgrade pip

RUN git clone git@github.com:Apstra/aeon-ztps.git

WORKDIR /root/aeon-ztps/install

RUN echo "127.0.0.1" > hosts
RUN ansible-playbook via-ansible.yml -i hosts
