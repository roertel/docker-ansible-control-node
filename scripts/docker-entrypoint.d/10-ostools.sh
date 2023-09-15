#!/bin/sh
# vim:sw=4:ts=4:et

if [ -n "${EXTRA_TOOLS:-}" ]; then
  echo "Installing extra tools via apk"
  apk add --update-cache --quiet ${EXTRA_TOOLS//,/ }
  rm -rf /var/lib/apk/db /var/cache/apk/*
fi
