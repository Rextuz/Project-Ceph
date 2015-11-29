#!/bin/bash
echo "Cleaning"
rm -rf /dev/rbd*
rm -rf /mnt/ceph-server
echo "Creating RBD"
rbd create foo --size 4096 -m 192.168.251.100:6790 -k /etc/ceph/keyring #-c /etc/ceph/ceph.conf
echo "Mapping RBD"
rbd map foo --name client.admin -m 192.168.251.100:6790 -k /etc/ceph/keyring #-c /etc/ceph/ceph.conf
echo "Formatting ext4"
mkfs.ext4 -m0 /dev/rbd/rbd/foo # not sure if we should use ext4 insted of xfs
echo "Mounting"
mkdir /mnt/ceph-server
mount /dev/rbd/rbd/foo /mnt/ceph-server
chown vagrant /mnt/ceph-server
echo "Success"
