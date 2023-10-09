# fuckup

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
