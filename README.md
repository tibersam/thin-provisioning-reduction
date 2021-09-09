# thin provisioned disk shrinking approach

The problem of thin provisioned disks for vms begins, when manny data is read and written to disk inside an VM.
The then thin provishioned sys disk is not reduced after deletion, because the data is not overwritten, only marked.
This means that a later hole punching of the thin provisioned disk is not possible.
A solution is to first fill the disk with zeros, then delete the zero file.
This makes hole punching possible.

The script needs to be executed in the VM.
It writes the remaining size of the root file system disk with zeros.
Then the file is deleted.
This only works if the vm's root filesystem does not have compression on a filesystem level enabled (e.g btrfs with compression).

Afterwards the handling in the backend depends on the used hypervisor.

## VMware ESXI
On an esxi system thin provisioned disk can be shrunk with this command.
'''
vmkfstools -K [VM Name].vmdk
'''

More information can be found [here](https://www.virten.net/2014/11/howto-shrink-a-thin-provisioned-virtual-disk-vmdk/).

## ZFS backed hypervisor
If youre disk are provided from a zfs storage, it is enough to have file system compression enabled. The zero file is realy easy to compress. The footprint is further reduced if deduplication is enabled, as it then will link all zero blocks to the same block. If you have exported a zvol of a zfs system to an VMware ESXI host, you can run the command on the ESXI server in addition.


Other cases i am currently not aware of, but if this is helpfull on your virtualisation system, use the simple script.
Furthermore, if you want to, open an issue to add the information in this readme.
