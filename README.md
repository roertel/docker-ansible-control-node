# docker-ansible-control-node

Ansible control node docker image. Run ansible in a predictable, controlled environment. 

## Usage
```
docker run -it --name ansible --rm \
	-v ansible-config:/etc/ansible \
	-v ansible-data:/usr/share/ansible \
	-e GITREPO=ssh://user@repository.com:/usr/local/src/ansible.git \
	-e NOEXIT docker.io/roertel/ansible-control-node
```
## Environment Variables

GITREPO - Git repository to clone ansible plays from
GITBRANCH - Git branch to switch to
EXTRA_TOOLS - Comma-delimited list of extra OS tools to install (via apk) (This only works when run as root)
PYTHON_MODULES - Comma-delimited extra Python modules to install (This only works when run as root)
ENTRYPOINT_QUIET_LOGS - set to 'true' to silence the entrypoint messages
ANSIBLE_ARGS - extra arguments to the default ansible-playbook command
NOEXIT - Keep the container running in an infinite sleep. Kill the sleep to terminate. This makes it easier to attach to the container.

## Building

```
make
```
