FROM python:3.9-alpine

ARG ANSIBLE_VERSION=2.9.9
ARG MOLECULE_VERSION=3.0.4
ARG YAMLLINT_VERSION=1.23.0
ARG ANSIBLELINT_VERSION=4.2.0
ARG MOLECULE_GOSS=1.0.0

RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories \
	&& apk add --update curl openssl ca-certificates bash git zip docker openssh-client \
	&& apk add --no-cache --virtual build-dependencies linux-headers build-base python3-dev libffi-dev openssl-dev py-psutil rust cargo \
	&& pip3 install --no-cache-dir --upgrade pip setuptools \
	&& pip3 install --upgrade ansible==${ANSIBLE_VERSION} molecule==${MOLECULE_VERSION} yamllint==${YAMLLINT_VERSION} docker \
	molecule-goss==${MOLECULE_GOSS} \
	&& pip3 install ansible-lint==${ANSIBLELINT_VERSION} \
	&& apk del build-dependencies \
    && rm -rf /var/cache/apk/* \
    && rm -r /root/.cache \
    && ansible --version \
    && molecule --version \
    && yamllint --version

RUN addgroup -S myusergroup && adduser -S myuser -G myusergroup
#USER myuser

RUN echo "    IdentityFile ~/.ssh/id_rsa" >> /etc/ssh/ssh_config \
	&& mkdir /root/.ssh

COPY config /root/.ssh/config

WORKDIR /home/myuser

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint.sh"]
