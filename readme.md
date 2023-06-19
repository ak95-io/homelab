# Setting up Ubuntu Server on FDD7 Proxmox

_Disclaimer: do this at your own risk. No fancy web GUI here (except monitoring), just raw Unix power._

<!-- TODO fixme-->
[![DD7](./img/microservergen10.jpeg)](./img/microservergen10.jpeg)

## Original projects
* [WD PR4100](https://github.com/aamkye/ubuntu_on_WD_PRx100)
* [HPE ProLiant G10](https://github.com/aamkye/ubuntu_on_HPE_ProLiant_MS_GEN10)

<!-- TODO fixme-->
## Overview

This tutorial covers how to install Ubuntu Server on DD7 in ProxMox.

It goes from preparation, downloading required packages, running installation, initial configuration and extras that most likely are intended to be used.

---

<!-- TODO fixme-->
## Ansible (automated way)

There is Ansible automatization of most steps and more.

---

## DD7 Spec

```
* Release date: N/A
* CPU: Intel Xeon E5-2699v4 (22c/44t, 2.2GHz, 145W)
* RAM: 256GB (8 x 32GB) DDR4-2400 ECC RDIMM
* Bays: 21 x 3.5"
* HDD: 16 x 3.5" SATA 6 Gbit/s
* PCIE:
  * LSI 9305-16e 16-port 12Gb/s SAS/SATA HBA
  * 2x Qnap QM2-384 4x M.2 NVMe
* LAN: 2 x 1 Gbit/s Ethernet
```

---

<!-- TODO fixme-->
## Requirements

* Ansible

---

# Ansible

<!-- TODO fixme-->
## Cloud-install config generation

```bash
ansible-playbook autoinstall-generator.yml
```

Then take `./tmp/user-data` file and place it on http(s) server.

## Get ISO

Download chosen iso from [here](https://ubuntu.com/download/server).


<!-- TODO fixme-->
## Ansible part (optional)

Just run:

```bash
ansible-playbook all_in_one_nas.yml --ask-become-pass -e "target=10.0.0.101" -i 10.0.0.101,
```

And watch the magic.

After it's done, it's done :)

<!-- TODO fixme-->
## Extras

* [ZFS](./readme/zfs.md)
