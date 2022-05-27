#!/bin/bash
if [ -z "$1" ]
then
  echo "usage: set-password [postgres-password]"
  exit 1
fi
export POSTGRES_PASSWORD=$1
