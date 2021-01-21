FROM python:alpine
LABEL maintainer="Ryan Oertel <ryan.oertel@gmail.com>"

VOLUME /etc/ansible
VOLUME /usr/share/ansible

RUN apk add --update-cache --quiet git screen vim ansible docker-py \
  openssh-client py3-dnspython ansible-lint && \
  rm -rf /var/lib/apk/db /var/cache/apk/*

# Copy in our entrypoint scripts
COPY scripts /
RUN chmod -f +x /docker-entrypoint.sh /docker-entrypoint.d/*.sh

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ansible-playbook", "/usr/share/ansible/site.yaml"]
