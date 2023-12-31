#!/usr/bin/env bash

# export PS4='+ $0:$LINENO '
# set -x

NOW_DATE="$(date +%d.%m.%YT%H:%M:%S%z)"

function pad-line() {
  # $1 - content
  export pad=$(printf '%0.1s' "#"{1..80})
  export padlength=80
  export pad_prefix="$(printf '%0.1s' "#"{1..3}) "
  export pad_suffix=" "
  export pad_special_sufix=" $(printf '%0.1s' "#"{1..3}) "
  if [[ $((${#1} + 8)) -gt 80 ]]; then
    printf "%s\n" "${pad_prefix}${1}${pad_special_sufix}"
  else
    printf "%s%*.*s%s\n" "${pad_prefix}${1}${pad_suffix}" 0 $((padlength - ${#pad_prefix} - ${#1} - ${#pad_suffix} - 1)) "$pad"
  fi
}

function syncoid-backup() {
  pad-line "${NOW_DATE} ${1} to ${2}"
  /usr/sbin/syncoid --no-sync-snap --delete-target-snapshots $1 $2
  echo -e
}

syncoid-backup elephant/work backup:ant/backup-work 2>&1 | tee /tmp/cron.syncoid.backup.log
syncoid-backup cheetah/timemachine backup:ant/backup-timemachine 2>&1 | tee /tmp/cron.syncoid.backup.log
