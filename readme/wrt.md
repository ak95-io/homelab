# OpenWRT 22.03 config via Ansible

## Repos
- https://downloads.openwrt.org/releases/22.03.0/targets/mvebu/cortexa9/packages/
- https://downloads.openwrt.org/releases/packages-22.03/arm_cortex-a9_vfpv3-d16/packages/
- https://downloads.openwrt.org/releases/packages-22.03/arm_cortex-a9_vfpv3-d16/base/
- https://openwrt.org/packages/pkgdata/
- https://www.jwillikers.com/dns-over-tls-with-unbound
- https://blog.cloudflare.com/dns-over-tls-for-openwrt/
- https://developers.cloudflare.com/1.1.1.1/setup/router/
- https://1.1.1.1/help
- https://blog.nlnetlabs.nl/dns-over-https-in-unbound/
- https://unbound.docs.nlnetlabs.nl/en/latest/topics/privacy/aggressive-nsec.html
- https://unbound.docs.nlnetlabs.nl/en/latest/topics/privacy/dns-over-https.html
- https://www.nlnetlabs.nl/documentation/unbound/unbound.conf/
- https://github.com/hillz2/openwrt_cloudflare_warp
- https://github.com/openwrt/packages/blob/master/net/unbound/Makefile
- https://github.com/NLnetLabs/unbound/issues/445
- https://unbound.docs.nlnetlabs.nl/en/latest/getting-started/configuration.html?highlight=unbound_server.pem#set-up-remote-control
-

## Commands

* Update all: `opkg update && opkg upgrade $(opkg list-upgradable | awk '{ print $1 }')`
* Show keys: `uci show dropbear; ls -l /etc/dropbear; cat /etc/dropbear/authorized_keys`
* Delete all entries: `while uci -q delete dhcp.@dnsmasq[0]; do :; done`
* Soft reset: `firstboot -y && reboot`
* Hard reset: `umount /overlay && jffs2reset && reboot`
* Open ports: `lsof -i -P -n`
* Resinstall coreutils: `opkg install coreutils coreutils-sort --force-reinstall`
* Read logs: `logread -f`
* Delete uci tree: `for line in $(uci show mwan3 | sed '1!G;h;$!d' | cut -f1 -d"="); do echo $line; uci delete $line; done`
* Force renew cert: `/usr/lib/acme/acme.sh --home /etc/acme --renew -d router.dc0.ak95.io --debug --ecc --force`

## Types of data structures used:

### Managed:

```yaml
<type>:
  - __type: <type>
    __root: <root_name>
    __name: <name>
    __fields:
      field1: 1
      field2: 0
  - __type: <type>
    __root: <root_name>
    __name: <name>
    __fields:
      field1: 2
      field2: 5
```

### Unmanaged:

```yaml
<type>:
  - __type: <type>
    __root: <root_name>
    __fields:
      field1: 1
      field2: 0
  - __type: <type>
    __root: <root_name>
    __fields:
      field1: 2
      field2: 5
```

```bash
luci-app-advanced-reboot
luci-app-diag-core
luci-app-statistics
```
