#!/usr/bin/env bash

set -ex

pushd $(dirname -- $( readlink -f -- ${1}))

# fail if not $1 provided
if [ -z "$1" ]; then
  echo "Usage: $0 <ubuntu-iso>"
  exit 1
fi

#check if iso is not present
if [ ! -f "$1" ]; then
  echo "File $1 not found"
  exit 1
fi

rm -f ${1/.iso/-autoinstall.iso}

docker run --rm \
  --privileged \
  --volume "$(pwd):/data/image" \
  --user $(id -u):$(id -g) \
  deserializeme/pxeless \
    -a \
    -u image/user-data \
    -s image/${1} \
    -d image/${1/.iso/-autoinstall.iso}

scp ./${1/.iso/-autoinstall.iso} dd7:/var/lib/vz/template/iso/

rm -f ${1/.iso/-autoinstall.iso}
