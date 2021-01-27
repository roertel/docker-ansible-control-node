#!/bin/sh
# vim:sw=4:ts=4:et

ansible_path=/usr/share/ansible

if [ -n "${GITREPO:-}" ]; then
  git -C ${ansible_path} status 1>/dev/null 2>&1

  if [ 128 -eq $? ]; then
    # No git repository at $ansible_path, so clone it
    echo "Cloning git repository"
    git clone ${GITREPO} ${ansible_path}
  fi
fi

if [ -n "${GITBRANCH:-}" ]; then
  git -C ${ansible_path} status 1>/dev/null 2>&1

  if [ 0 -eq $? ]; then
    # Git repository present, checkout the branch
    echo "Checking out git branch ${GITBRANCH}"
    git -C ${ansible_path} branch ${GITBRANCH}
  fi
fi
