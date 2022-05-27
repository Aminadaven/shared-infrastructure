#!/bin/sh

echo "$@"

# Check if to build minimal or full JRE
if [ "$1" = "min" ]
then
  MODULES=java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument,jdk.unsupported
  echo "Minimal JRE mode"
elif [ "$1" = "max" ]
then
  MODULES=ALL-MODULE-PATH
    echo "Full JRE mode"
fi

apk upgrade -U --available

  apk add --no-cache binutils
# Check if to add fonts support
if [ "$2" = "fonts" ]
then
  echo "Adding fonts support"
  apk add --no-cache fontconfig font-overpass && fc-cache -f
fi

# Create the minimal JRE
jlink \
  --module-path "$JAVA_HOME"/jmods:/opt/java/jmods \
  --compress=2 \
  --add-modules \
  $MODULES \
  --strip-debug \
  --no-header-files \
  --no-man-pages \
  --ignore-signing-information \
  --output /lib/runtime

# Thinning out libraries
rm -rf /lib/apk
rm -rf /lib/runtime/legal
rm -rf /lib/runtime/security
strip --strip-unneeded /lib/runtime/lib/server/libjvm.so
cd /lib/runtime/lib || exit
for i in $(ls /lib/runtime/lib | grep -i so | awk '{print $1}'); do strip --strip-unneeded "$i"; done
rm -rf /tmp/*

# Create non-root user to copy
APPLICATION_USER=scratch-jre
adduser --no-create-home -u 1000 -D $APPLICATION_USER

# Configure working directory
mkdir /app
chown -R $APPLICATION_USER /app
