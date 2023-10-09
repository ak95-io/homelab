# ZFS workbook

## Inventory

```shell
# Cheetach - WD RED SN700
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835
```

```shell
# Kangaroo - WD RED
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF
```

```shell
# Elephant - WD HC550
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGB979V
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBMBYV
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_6RGJRH5U
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBLTEV
```

## Create and import

```shell
> sudo zpool destroy -f cheetah

# Cheetach (encryption+compression)
> sudo zpool create \
cheetah \
raidz2 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200 \
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835 \
-o ashift=14 \
-o autoexpand=on \
-o autotrim=on \
-O xattr=sa \
-O compression=lz4 \
-O atime=on \
-O relatime=on \
-O recordsize=1M \
-O checksum=edonr \
-O encryption=aes-256-gcm \
-O keylocation=prompt \
-O keyformat=passphrase \
-O mountpoint=/mnt/cheetah

> sudo zpool import \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200 \
-d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835 \
cheetah

# > sudo zfs create cheetah/data
# > sudo zfs create cheetah/work
# > sudo zfs create cheetah/ps-games
# > sudo zfs create cheetah/timemachine
```

```shell
# Elephant (encryption+compression)
> sudo zpool destroy -f elephant

> sudo zpool create \
elephant \
raidz2 \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGB979V \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBMBYV \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_6RGJRH5U \
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBLTEV \
-o ashift=14 \
-o autoexpand=on \
-o autotrim=on \
-O xattr=sa \
-O compression=lz4 \
-O atime=on \
-O relatime=on \
-O recordsize=1M \
-O checksum=edonr \
-O encryption=aes-256-gcm \
-O keylocation=prompt \
-O keyformat=passphrase \
-O mountpoint=/mnt/elephant

> sudo zpool import \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGB979V \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBMBYV \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_6RGJRH5U \
-d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2KGBLTEV \
elephant

# > sudo zfs create elephant/music
# > sudo zfs create elephant/video
# > sudo zfs create elephant/jellyfin
```

```shell
# kangaroo (encryption+compression)
> sudo zpool destroy -f kangaroo

> sudo zpool create \
kangaroo \
raidz1 \
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG \
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G \
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG \
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF \
-o ashift=14 \
-o autoexpand=on \
-o autotrim=on \
-O xattr=sa \
-O compression=lz4 \
-O atime=on \
-O relatime=on \
-O recordsize=1M \
-O checksum=edonr \
-O encryption=aes-256-gcm \
-O keylocation=prompt \
-O keyformat=passphrase \
-O mountpoint=/mnt/kangaroo

> sudo zpool import \
-d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG \
-d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G \
-d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG \
-d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF \
kangaroo

# > sudo zfs create kangaroo/backup-x
# > sudo zfs create kangaroo/tmp-torrent
```

```shell
# ant (noencryption+compression)
> sudo zpool destroy -f ant

> sudo zpool create \
ant \
/dev/disk/by-id/scsi-SATA_WDC_WD2003FYPS-2_WD-WCAVY7201799 \
-o ashift=14 \
-o autoexpand=on \
-o autotrim=on \
-O xattr=sa \
-O compression=lz4 \
-O atime=on \
-O relatime=on \
-O recordsize=1M \
-O checksum=edonr \
-O mountpoint=/mnt/ant

> sudo zpool import \
-d /dev/disk/by-id/scsi-SATA_WDC_WD2003FYPS-2_WD-WCAVY7201799 \
ant

# > sudo zfs create ant/backup-x

## Migration helpers

```shell
# Rsync on steroids
alias rsync+='rsync \
  --partial \
  --progress \
  --recursive \
  --times \
  --stats \
  --human-readable \
  --no-compress \
  --verbose \
  --append-verify'

# List all disks with links
function list-disk-by-id-with-link() {
  ls -l /dev/disk/by-id/* | \
  grep -E '(scsi-SATA|nvme-[^e]).*[A-Z0-9]{8}\W\->' | \
  tr -s ' ' | \
  cut -d ' ' -f 9,11 | \
  sed -e 's,\.\.\/\.\.,/dev,g'
}

# List all disks
function list-disk-by-id() {
  ls -l /dev/disk/by-id/* | \
  grep -E '(scsi-SATA|nvme-[^e]).*[A-Z0-9]{8}\W\->' | \
  tr -s ' ' | \
  cut -d ' ' -f 9 | \
  sed -e 's,\.\.\/\.\.,/dev,g'
}

# Load encrypted pool
function zload() {
  sudo zfs load-key -L prompt $1 && sudo zfs mount -a
}

# Unload encrypted pool
function zunload() {
  sudo zfs unmount -f $1 && sudo zfs unload-key $1
}

# Load all encrypted pools
function zload-all() {
  IFS=$'\n'
  POOLS=$(zpool get feature@encryption | grep active | tr -s ' ' | cut -d ' ' -f1)

  if [[ -n "$PASS" ]]; then
    for pool in ${POOLS}; do
      echo $PASS | sudo zfs load-key -L prompt $pool
    done
    sudo zfs mount -a
    unset PASS
    zfs get mounted
  else
    echo "PASS missing.."
    exit 1
  fi
}

# Times are in UTC to avoid DST issues.
function list-zfs-snapshots() {
  zfs list -t snapshot -o name -S creation $@
}

# Delete snapshots containing a string
function delete-zfs-snapshots() {
  zfs list -t snapshot -o name | grep $1 | xargs -n1 zfs destroy -r
}
```

## syncoid backup script

```shell


## partition backup script

```shell
#!/usr/bin/env bash

# https://www.cyberciti.biz/faq/linux-backup-restore-a-partition-table-with-sfdisk-command/
# https://www.golinuxcloud.com/backup-copy-restore-partition-table-sfdisk/

export PS4='+ $0:$LINENO '
set -x

export BACKUP="partition.backup.$(hostname).$(BACKUP +%Y.%m.%dT%H.%M.%S%z)"
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
```

## Sanoid config
```shell
[cheetah]
  use_template = production
  recursive = yes
  process_children_only = yes

[elephant]
  use_template = production
  recursive = yes
  process_children_only = yes

#############################
# templates below this line #
#############################

[template_production]
  frequently = 0
  hourly = 48
  daily = 60
  monthly = 3
  yearly = 0
  autosnap = yes
  autoprune = yes

  hourly_min = 0

  daily_hour = 0
  daily_min = 0

  weekly_wday = 1
  weekly_hour = 0
  weekly_min = 0

  monthly_mday = 1
  monthly_hour = 0
  monthly_min = 0
```

## Syncoid crontab

```shell
0 1 * * * /usr/sbin/syncoid --no-sync-snap --delete-target-snapshots elephant/work backup:ant/backup-work >> /var/log/cront.syncoid.log 2>&1 && \
          /usr/sbin/syncoid --no-sync-snap --delete-target-snapshots cheetah/timemachine kangaroo/backup-timemachine >> /var/log/cront.syncoid.log 2>&1

###

#!/usr/bin/env bash

set -x
export PS4='+ $0:$LINENO '
shopt -s extglob

export NOW_DATE="$(date +%s)"

# \[${1//+([\:\/])/-}\].to.[${2//+([\:\/])/-}\].${NOW_DATE}
function syncoid-backup() {
  pad=$(printf '%0.1s' "#"{1..80})
  padlength=80

  printf "%s%*.*s%s\n" "### ${NOW_DATE} ${1} to ${2} " 0 $((padlength - ${#1} - ${#2})) "$pad"
  /usr/sbin/syncoid --no-sync-snap --delete-target-snapshots $1 $2
}

syncoid-backup elephant/work backup:ant/backup-work >> /tmp/cron.syncoid.log 2>&1

```

## Change user and permissions

```shell
# scraper
sudo chown aam:operations -R . && \
find . -type d -exec chmod 775 {} \; && \
find . -type f -exec chmod 664 {} \;

# after
rename 'y/A-Z/a-z/' ./* && \
rename 'y/\ /./' ./* && \
rename 's/(\-|\+)/\./g' ./* && \
rename 's/(\(|\)|\{|\}|\[|\])//g' ./* && \
rename 's/(\.)+/\./g' ./*

rename 's/^/007\./' *.mkv
```

## Jellyfin

```shell
# jellyfin
docker run -d \
--name jellyfin \
--user 2000:2000 \
--net=host \
--group-add="44" \
--group-add="107" \
--volume /mnt/elephant/jellyfin/config:/config \
--volume /mnt/elephant/jellyfin/cache:/cache \
--mount type=bind,source=/mnt/elephant/video/,target=/media \
--restart=unless-stopped \
--device /dev/dri/renderD128:/dev/dri/renderD128 \
-e JELLYFIN_FFmpeg__analyzeduration=200000000 \
-e JELLYFIN_FFmpeg__probesize=5000000 \
jellyfin/jellyfin
```

## TimeMachine

```shell
# timemachine
docker run -d --restart=always \
--name timemachine \
--net=host \
-e ADVERTISED_HOSTNAME="" \
-e CUSTOM_SMB_CONF="false" \
-e CUSTOM_USER="false" \
-e DEBUG_LEVEL="1" \
-e MIMIC_MODEL="TimeCapsule8,119" \
-e EXTERNAL_CONF="" \
-e HIDE_SHARES="no" \
-e TM_USERNAME="timemachine" \
-e TM_GROUPNAME="timemachine" \
-e TM_UID="1000" \
-e TM_GID="1000" \
-e PASSWORD="timemachine" \
-e SET_PERMISSIONS="false" \
-e SHARE_NAME="TimeMachine" \
-e SMB_INHERIT_PERMISSIONS="no" \
-e SMB_NFS_ACES="yes" \
-e SMB_METADATA="stream" \
-e SMB_PORT="445" \
-e SMB_VFS_OBJECTS="acl_xattr fruit streams_xattr" \
-e VOLUME_SIZE_LIMIT="0" \
-e WORKGROUP="WORKGROUP" \
-v /mnt/cheetah/timemachine/:/opt/timemachine \
-v timemachine-var-lib-samba:/var/lib/samba \
-v timemachine-var-cache-samba:/var/cache/samba \
-v timemachine-run-samba:/run/samba \
mbentley/timemachine:smb
```

## Deluge

# deluge_exporter
```shell
docker run -d \
--restart unless-stopped \
-e "DELUGE_HOST=172.17.0.1" \
-v /home/aam/.config/deluge/:/root/.config/deluge/ \
-p 9354:9354 \
--name deluge_exporter \
tobbez/deluge_exporter:latest
```

## Guckup -

```shell
root@nas:/opt/zfs# zpool import
   pool: tortoise
     id: 12200569851314458467
  state: UNAVAIL
status: One or more devices contains corrupted data.
 action: The pool cannot be imported due to damaged devices or data.
   see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-5E
 config:

        tortoise                                   UNAVAIL  insufficient replicas
          raidz1-0                                 UNAVAIL  insufficient replicas
            scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG    ONLINE
            scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G    ONLINE
            scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG    UNAVAIL  corrupted data
            scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF    UNAVAIL  corrupted data
        logs
          mirror-1                                 ONLINE
            nvme-WD_Red_SN700_2000GB_23024R800705  ONLINE
            nvme-WD_Red_SN700_2000GB_23024R800272  ONLINE

root@nas:/home/aam# zpool import
   pool: tortoise
     id: 12200569851314458467
  state: UNAVAIL
status: One or more devices contains corrupted data.
 action: The pool cannot be imported due to damaged devices or data.
   see: https://openzfs.github.io/openzfs-docs/msg/ZFS-8000-5E
 config:

        tortoise                                   UNAVAIL  insufficient replicas
          raidz1-0                                 UNAVAIL  insufficient replicas
            scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG    ONLINE
            scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G    ONLINE
            scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG    UNAVAIL  corrupted data
            scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF    UNAVAIL  invalid label
        logs
          mirror-1                                 ONLINE
            nvme-WD_Red_SN700_2000GB_23024R800705  ONLINE
            nvme-WD_Red_SN700_2000GB_23024R800272  ONLINE
```
