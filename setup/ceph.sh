#!/bin/bash

# Install and configure ceph
sudo apt-get update && sudo apt-get install wget vim xfsprogs -y
wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update && sudo apt-get install ceph-common -y
sudo cp /vagrant/setup/ceph.conf /etc/ceph/ceph.conf
sudo cp /vagrant/setup/keyring /etc/ceph/keyring

# Setup RBD mount
if [[ "$1" -eq 1 ]]; then
  rbd create foo --size 4096 -c /etc/ceph/ceph.conf
fi
sudo rbd map foo --pool rbd --name client.admin -c /etc/ceph/ceph.conf
if [[ "$1" -eq 1 ]]; then
  sudo mkfs.xfs -L ceph_drive /dev/rbd0
fi
mkdir ceph_folder
sudo mount -t xfs /dev/rbd0 ceph_folder/
sudo chown vagrant ceph_folder/
