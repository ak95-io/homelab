# ZFS workbook

## Inventory

```shell
# Cheetach - WD RED SN700
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274 /dev/nvme0n1
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291 /dev/nvme1n1
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133 /dev/nvme2n1
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267 /dev/nvme3n1

# Log tortoise
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705 /dev/nvme4n1
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272 /dev/nvme5n1

# Log elephant
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200 /dev/nvme6n1
/dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835 /dev/nvme7n1
```

```shell
# Tortoise - WD RED
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG /dev/sde
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G /dev/sdf
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG /dev/sdb
/dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF /dev/sdg
```

```shell
# Elephant - WD HC550
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT /dev/sdi
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT /dev/sdd
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT /dev/sdh
/dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH /dev/sdc
```

## Create and import

```shell
# Cheetach
> sudo zpool create \
  cheetah \
  raidz1 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267 \
  -O encryption=aes-256-gcm \
  -O keylocation=prompt \
  -O keyformat=passphrase \
  -O mountpoint=/mnt/cheetah

> sudo zpool import \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800274 \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800291 \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800133 \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800267 \
  cheetah

# > sudo zfs create cheetah/data
# > sudo zfs create cheetah/work
```

```shell
# Elephant
> sudo zpool create \
  elephant \
  raidz1 \
  /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT \
  /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT \
  /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT \
  /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH \
  -O encryption=aes-256-gcm \
  -O keylocation=prompt \
  -O keyformat=passphrase \
  -O mountpoint=/mnt/elephant

> sudo zpool add \
  elephant \
  log mirror \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835

> sudo zpool import \
  -d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKW62BT \
  -d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2BKZBNDT \
  -d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_2PJ0LDMT \
  -d /dev/disk/by-id/scsi-SATA_WDC_WUH721816AL_4YGA3LWH \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800200 \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800835 \
  elephant

# > sudo zfs create elephant/music
# > sudo zfs create elephant/video
# > sudo zfs create elephant/torrent
```

```shell
# Tortoise
> sudo zpool create \
  tortoise \
  raidz1 \
  /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG \
  /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G \
  /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG \
  /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF \
  -O encryption=aes-256-gcm \
  -O keylocation=prompt \
  -O keyformat=passphrase \
  -O mountpoint=/mnt/tortoise

> sudo zpool add \
  tortoise \
  log mirror \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705 \
  /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272

> sudo zpool import \
  -d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1J8JJBG \
  -d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JAPH9G \
  -d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_V1JASWGG \
  -d /dev/disk/by-id/scsi-SATA_WDC_WD4003FFBX-6_VBGJN8SF \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800705 \
  -d /dev/disk/by-id/nvme-WD_Red_SN700_2000GB_23024R800272 \
  tortoise
```

## Migration

```shell
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

alias dev-disk-by-id="ls -l /dev/disk/by-id/* | \
  grep -E '(scsi-SATA_WD|nvme-[^e]).*[A-Z0-9]{5}\W\->' | \
  tr -s ' ' | \
  cut -d ' ' -f 9,11 | \
  sed -e 's,\.\.\/\.\.,/dev,g'"

function zload() {
  sudo zfs load-key -L prompt $1 && sudo zfs mount -a
}

function zunload() {
  sudo zfs unmount -f $1 && sudo zfs unload-key $1
}
```

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
  -v /mnt/tortoise/timemachine/:/opt/timemachine \
  -v timemachine-var-lib-samba:/var/lib/samba \
  -v timemachine-var-cache-samba:/var/cache/samba \
  -v timemachine-run-samba:/run/samba \
  mbentley/timemachine:smb
```

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
