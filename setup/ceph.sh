#!/bin/bash

# Install and configure ceph
sudo apt-get update && sudo apt-get install wget vim -y
wget -q -O- 'https://ceph.com/git/?p=ceph.git;a=blob_plain;f=keys/release.asc' | sudo apt-key add -
echo deb http://ceph.com/debian/ $(lsb_release -sc) main | sudo tee /etc/apt/sources.list.d/ceph.list
sudo apt-get update && sudo apt-get install ceph-common -y
sudo mkdir /etc/ceph
sudo cp /vagrant/setup/ceph.conf /etc/ceph/ceph.conf
sudo cp /vagrant/setup/keyring /etc/ceph/keyring

# Setup RBD mount
sudo apt-get install xfsprogs -y
rbd create foo --size 4096 -c /etc/ceph/ceph.conf
sudo rbd map foo --pool rbd --name client.admin -c /etc/ceph/ceph.conf
sudo mkfs.xfs -L ceph_drive /dev/rbd0
mkdir ceph_drive
sudo mount -t xfs /dev/rbd0 ceph_drive/
# sudo echo '/dev/rbd0 /home/vagrant/ceph_drive xfs defaults 0 0' >> /etc/fstab