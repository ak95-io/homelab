#!/usr/bin/env bash

# yamler.sh - a simple YAML parser that adds "---" at the beggining of ya?ml files.
fixes=0

# Fail if no args provided
if [ -z "$1" ]; then
  echo "Usage: $0 <path>"
  exit 1
fi

for file in $(find $1 -type file \( -name "*.yaml" -o -name "*.yml" \)); do
  if [[ $(head -n 1 $file) != "---" ]]; then
    echo "File $file not having \"---\". FiXiNg It."
    sed -i '1i---' $file
    fixes=$((fixes+1))
  fi
done

if [[ $fixes -eq 0 ]]; then
  echo "All good. No files to fix."
fi
