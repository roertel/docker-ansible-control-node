# docker-ansible-control-node
Ansible control node docker image

Environment Variables
GITREPO - Git repository to clone ansible plays from
GITBRANCH - Git branch to switch to
EXTRA_TOOLS - extra OS tools to install (via apk)
PYTHON_MODULES - extra Python modules to install
ENTRYPOINT_QUIET_LOGS - set to 'true' to silence the entrypoint messages
ANSIBLE_ARGS - extra arguments to the default ansible-playbook command
