FROM python:3.6-alpine

ARG ANSIBLE_VERSION=2.4.0
ARG MOLECULE_VERSION=2.19.0
ARG YAMLLINT_VERSION=1.15.0

RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/community" >> /etc/apk/repositories \
	&& apk add --update curl openssl ca-certificates bash git zip docker openssh-client \
	&& apk add --no-cache --virtual build-dependencies linux-headers build-base python3-dev libffi-dev openssl-dev py-psutil \
	&& pip3 install --no-cache-dir --upgrade pip setuptools \
	&& pip3 install --upgrade ansible==${ANSIBLE_VERSION} molecule==${MOLECULE_VERSION} yamllint==${YAMLLINT_VERSION} docker \
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
