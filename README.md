# docker-ansible-control-node
Ansible control node docker image

Environment Variables
GITREPO - Git repository to clone ansible plays from
GITBRANCH - Git branch to switch to
EXTRA_TOOLS - extra OS tools to install (via apk)
PYTHON_MODULES - extra Python modules to install
ENTRYPOINT_QUIET_LOGS - set to 'true' to silence the entrypoint messages
ANSIBLE_ARGS - extra arguments to the default ansible-playbook command
NOEXIT - Keep the container running in an infinite sleep. Kill the sleep to terminate. This makes it easier to attach to the container.

Example:
docker run -it --name ansible  --rm -v ansible-config:/etc/ansible -v ansible-data:/usr/share/ansible -e GITREPO=ssh://ryan@oertelnet.com:/usr/local/src/ansible.git -e NOEXIT ansible-control-node
