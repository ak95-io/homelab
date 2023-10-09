#!/usr/bin/env bash

set -ex

export IMG_DIR=$(dirname -- $( readlink -f -- ${1}))
export IMG_NAME=$(basename -- ${1})
export USER_DATA_DIR=$(dirname -- $( readlink -f -- ${2}))
export USER_DATA_NAME=$(basename -- ${2})
export NEW_IMAGE_NAME=${IMG_NAME/.iso/-${USER_DATA_NAME/user-data-/}-autoinstall.iso}

# fail if args differs 2
if [ $# -ne 2 ]; then
  echo "Usage: $0 <ubuntu-iso> <user-data>"
  exit 1
fi

#check if iso and user-data is present
if [ ! -f "$1" ]; then
  echo "Image $1 not found"
  exit 1
elif [ ! -f "$2" ]; then
  echo "User-data $2 not found"
  exit 1
fi

# rm image with autoinstall if exists
if [ -f "${IMG_DIR}/${NEW_IMAGE_NAME}" ]; then
  rm -f ${IMG_DIR}/${NEW_IMAGE_NAME}
fi

docker run --rm \
  --privileged \
  --volume "${IMG_DIR}:/data/image" \
  --volume "${USER_DATA_DIR}/${USER_DATA_NAME}:/data/user-data" \
  --user $(id -u):$(id -g) \
  deserializeme/pxeless \
    -a \
    -u user-data \
    -s image/${IMG_NAME} \
    -d image/${NEW_IMAGE_NAME}
