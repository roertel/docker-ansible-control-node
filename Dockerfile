FROM python:alpine
LABEL maintainer="Ryan Oertel <638327+roertel@users.noreply.github.com>"

VOLUME /etc/ansible
VOLUME /usr/share/ansible

RUN apk add --update-cache --quiet git ansible docker-py openssh-client \
  py3-dnspython ansible-lint helm py3-kubernetes py3-jsonpatch py3-yaml \
  py3-netaddr && rm -rf /var/lib/apk/db /var/cache/apk/*

# Copy in our entrypoint scripts
COPY scripts /
RUN chmod -f +x /docker-entrypoint.sh /docker-entrypoint.d/*.sh

# Set up the ansible user (so we don't use root)
RUN addgroup ansible && adduser -DG ansible ansible
USER ansible

# Set the entrypoint
WORKDIR /usr/share/ansible
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ansible-playbook", "site.yaml"]

