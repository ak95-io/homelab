#!/usr/bin/env bash

if [[ ${DEBUG:-0} -eq 1 ]]; then
  PS4='(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
  set -x
fi

# yamler.sh - a simple YAML parser that adds "---" at the beggining of yaml files and wraps all `- name: <text>` into the `- name: "<text>"`.
fixes=0

# Fail if no args provided
if [ -z "$1" ]; then
  echo "Usage: "
  echo "  [DEBUG=0] [DRY_RUN=0] $0 <path> \$(find roles -type file \( -name '*.yaml' -o -name '*.yml' \))"
  echo "  [DEBUG=0] [DRY_RUN=0] $0 <path> roles/**/*.yml"
  exit 1
fi

for file in $@; do
  if [[ $(head -n 1 $file) != "---" ]]; then
    MESSAGE="File $file not having \"---\" at the beggining."
    if [[ ${DRY_RUN:-1} -eq 0 ]]; then
      echo "$MESSAGE FiXiNg It."
      sed -i '1i---' $file
    else
      echo "$MESSAGE"
    fi
    fixes=$((fixes+1))
  fi

  if [[ $(grep -E '(\- name: )([A-z].*)' $file) ]]; then
    MESSAGE="File $file not having \"\" around \"- name: <text>\"."
    if [[ ${DRY_RUN:-1} -eq 0 ]]; then
      echo "$MESSAGE FiXiNg It."
      sed -i -r 's/(\- name: )([A-z].*)/\1"\2"/g' $file
    else
      echo "$MESSAGE"
    fi
    fixes=$((fixes+1))
  fi

  if [[ $(grep -ER '(: [^".]*{{.*}}.*)' $file) ]]; then
    MESSAGE="File $file not having \"\" around \"{{}}\"."
    if [[ ${DRY_RUN:-1} -eq 0 ]]; then
      echo "$MESSAGE FiXiNg It."
      sed -i -r 's/(: )([^".]*\{\{.*\}\}.*)/\1"\2"/g' $file
    else
      echo "$MESSAGE"
    fi
    fixes=$((fixes+1))
  fi
done

if [[ $fixes -eq 0 ]]; then
  echo "All good. No files to fix."
elif [[ ${DRY_RUN:-1} -eq 0 && $fixes -ne 0 ]]; then
  echo "Fixed $fixes files."
elif [[ ${DRY_RUN:-1} -eq 1 && $fixes -ne 0 ]]; then
  echo "Dry run. $fixes files to fix."
fi
