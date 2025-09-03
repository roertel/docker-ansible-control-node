FROM python:alpine
LABEL maintainer="Ryan Oertel <638327+roertel@users.noreply.github.com>"

RUN apk add --update-cache --quiet git ansible docker-py openssh-client \
   py3-dnspython ansible-lint helm py3-kubernetes py3-jsonpatch py3-netaddr \
   py3-boto3>=1.28.0 py3-botocore>=1.31.0 \
&& rm -rf /var/lib/apk/db /var/cache/apk/*

# Copy in our entrypoint scripts
COPY scripts /
RUN addgroup ansible \
&& adduser -DG ansible ansible \
&& mkdir -p /etc/ansible \
&& chown -fR ansible:ansible /etc/ansible \
&& chmod -f +x /docker-entrypoint.sh /docker-entrypoint.d/*.sh

# Set up the ansible user (so we don't use root)
USER ansible

VOLUME /etc/ansible
VOLUME /usr/share/ansible
WORKDIR /usr/share/ansible

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ansible-playbook", "site.yaml"]

