#!/bin/sh
# vim:sw=4:ts=4:et

if [ -n "${PYTHON_MODULES:-}" ]; then
  echo "Installing extra python modules"
  pip install --upgrade ${PYTHON_MODULES//,/ }
fi
