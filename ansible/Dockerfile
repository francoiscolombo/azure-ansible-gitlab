FROM alpine:3.8
 
ENV ANSIBLE_VERSION 2.5.0

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PYTHONPATH /ansible/lib
ENV PATH /ansible/bin:$PATH
ENV ANSIBLE_LIBRARY /ansible/library
ENV GITLAB_ROOT_PASSWORD "ChangeMe"
ENV GITLAB_USER_PASSWORD "ChangeMe"

ENV BUILD_PACKAGES \
  bash \
  curl \
  tar \
  openssh-client \
  sshpass \
  git \
  python \
  py-boto \
  py-dateutil \
  py-httplib2 \
  py-jinja2 \
  py-paramiko \
  py-pip \
  py-yaml \
  sudo \
  make \
  rsync \
  ca-certificates
 
RUN set -x && \
    \
    echo "==> Adding build-dependencies..."  && \
    apk --update add --virtual build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      openssl-dev \
      build-base \
      python-dev && \
    \
    echo "==> Upgrading apk and system..."  && \
    apk update && apk upgrade && \
    \
    echo "==> Adding Python runtime..."  && \
    apk add --no-cache ${BUILD_PACKAGES} && \
    pip install --upgrade pip cffi && \
    pip install pycrypto pywinrm python-keyczar docker-py && \
    \
    echo "==> Installing Ansible..."  && \
    pip install ansible==${ANSIBLE_VERSION} && \
    \
    echo "==> Cleaning up..."  && \
    apk del build-dependencies && \
    rm -rf /var/cache/apk/*

RUN set -x && \
    \
    echo "==> Create ansible user..."  && \
    addgroup -g 1000 -S ansible && \
    adduser -u 1000 -S ansible -G ansible -h /ansible && \
    mkdir -p /ansible/playbooks /ansible/.ssh && \
    chmod 700 /ansible/.ssh

COPY platform.yml /ansible/
COPY gitlab-install-playbook.yml /ansible/playbooks/
COPY gitlab-config-playbook.yml /ansible/playbooks/

COPY admgitlab.rsa /ansible/.ssh/
COPY admgitlab.rsa.pub /ansible/.ssh/
COPY ssh_config /ansible/.ssh/

RUN chmod 400 /ansible/.ssh/admgitlab.rsa && \
    chmod 400 /ansible/.ssh/admgitlab.rsa && \
    chown -R ansible:ansible /ansible

WORKDIR /ansible

USER ansible

ENTRYPOINT [ "ansible-playbook", "-i", "/ansible/platform.yml", "-u", "admgitlab", "--private-key", "/ansible/.ssh/admgitlab.rsa" ]
CMD [ "/ansible/playbooks/gitlab-install-playbook.yml" ]
