FROM debian:stable-slim
LABEL maintainer="Ryan Oertel <638327+roertel@users.noreply.github.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --quiet \
&& apt-get install --quiet --assume-yes git ansible ansible-lint openssh-client \
   python3-dnspython python3-kubernetes python3-jsonpatch python3-netaddr \
   python3-boto3 \
&& rm -rf /usr/local/bin/python/* /var/lib/apt/lists/*

# Copy in our entrypoint scripts
COPY scripts /
RUN chmod -f +x /docker-entrypoint.sh /docker-entrypoint.d/*.sh \
&& mkdir -p /etc/ansible \
&& adduser ansible \
&& chown -fR ansible:ansible /etc/ansible

# Set up the ansible user (so we don't use root)
#USER ansible

VOLUME /etc/ansible
VOLUME /usr/share/ansible
WORKDIR /usr/share/ansible

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ansible-playbook", "site.yaml"]

