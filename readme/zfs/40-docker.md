# Docker

## Jellyfin

```shell
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

```shell
docker run -d \
--restart unless-stopped \
-e "DELUGE_HOST=172.17.0.1" \
-v /home/aam/.config/deluge/:/root/.config/deluge/ \
-p 9354:9354 \
--name deluge_exporter \
tobbez/deluge_exporter:latest
```
