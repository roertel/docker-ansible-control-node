#!/bin/sh
# vim:sw=4:ts=4:et

if [ -z "${ENTRYPOINT_QUIET_LOGS:-}" ]; then
    exec 3>&1
else
    exec 3>/dev/null
fi

# Don't run the configuration unless we're going to run ansible
if [ "$1" = "ansible" ] || [ "$1" = "ansible-playbook" ]; then
  find "/docker-entrypoint.d/" -follow -type f -print | sort -n | while read -r f; do
    case "$f" in
      *.sh)
        if [ -x "$f" ]; then
          echo >&3 "$0: Launching $f";
          "$f"
        else
          # warn on shell scripts without exec bit
          echo >&3 "$0: Ignoring $f, not executable";
        fi
        ;;
      *) echo >&3 "$0: Ignoring $f";;
    esac
  done

  echo >&3 "$0: Configuration complete; ready for start up"
fi

echo >&3 "$0: Executing '$@' with args '${ANSIBLE_ARGS}'"
exec "$@ ${ANSIBLE_ARGS}"
