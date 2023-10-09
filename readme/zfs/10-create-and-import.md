# Create and import

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
```
