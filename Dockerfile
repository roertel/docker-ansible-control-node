FROM debian:stable-slim
LABEL maintainer="Ryan Oertel <638327+roertel@users.noreply.github.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --quiet \
&& apt-get install --quiet --assume-yes curl gpg apt-transport-https \
&& curl -fsSL https://baltocdn.com/helm/signing.asc \
&& curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey \
   | gpg --dearmor > /usr/share/keyrings/helm.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" \
   > /etc/apt/sources.list.d/helm-stable-debian.list

RUN apt-get update --quiet \
&& apt-get install --quiet --assume-yes git ansible ansible-lint openssh-client \
   python3-dnspython python3-kubernetes python3-jsonpatch python3-netaddr \
   python3-boto3 helm

RUN apt-get purge --quiet --assume-yes curl gpg apt-transport-https \
&& rm -rf /usr/local/bin/python/* /var/lib/apt/lists/*

# Copy in our entrypoint scripts
COPY scripts /
RUN chmod -f +x /docker-entrypoint.sh /docker-entrypoint.d/*.sh \
&& mkdir -p /etc/ansible \
&& adduser ansible \
&& chown -fR ansible:ansible /etc/ansible

# Set up the ansible user (so we don't use root)
USER ansible

VOLUME /etc/ansible
VOLUME /usr/share/ansible
WORKDIR /usr/share/ansible

# Set the entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["ansible-playbook", "site.yaml"]

