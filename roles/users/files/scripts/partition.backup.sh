#!/usr/bin/env bash

# https://www.cyberciti.biz/faq/linux-backup-restore-a-partition-table-with-sfdisk-command/
# https://www.golinuxcloud.com/backup-copy-restore-partition-table-sfdisk/

# export PS4='+ $0:$LINENO '
# set -x

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

function partition-backup() {
  export BACKUP="partition.backup.$(hostname).$(date +%Y.%m.%dT%H.%M.%S%z)"
  pad-line $BACKUP

  mkdir $BACKUP

  for i in $(ls -l /dev/disk/by-id/* | \
    grep -E '(scsi-SATA|nvme-[^e]).*[A-Z0-9]{5}\W\->' | \
    tr -s ' ' | \
    cut -d ' ' -f 9 | \
    sed -e 's,\.\.\/\.\.,/dev,g') ; do

    sfdisk -d $i > $BACKUP/dump-$(basename $i).bak
    sfdisk -l $i > $BACKUP/info-$(basename $i).txt 2>&1
    sfdisk -b -O $BACKUP/backup $i
  done

  zpool status > $BACKUP/zpool-status.txt 2>&1 | true
  zpool list -v > $BACKUP/zpool-list.txt 2>&1 | true

  tar -czvf $BACKUP.tar.gz $BACKUP
  sha1sum $BACKUP.tar.gz > $BACKUP.tar.gz.sha1

  export B2_APPLICATION_KEY_ID="005bd638d319e990000000001"
  export B2_APPLICATION_KEY="K005LZedAWKlES5SINVdyNlLvpNZ2kk"

  b2 upload-file \
    aam-partition-backup \
    $BACKUP.tar.gz \
    $BACKUP.tar.gz

  b2 upload-file \
    aam-partition-backup \
    $BACKUP.tar.gz.sha1 \
    $BACKUP.tar.gz.sha1

  unset B2_APPLICATION_KEY_ID
  unset B2_APPLICATION_KEY

  rm -rf $BACKUP*

  echo -n ""
}

partition-backup 2>&1 | tee /tmp/cron.partition.backup.log
