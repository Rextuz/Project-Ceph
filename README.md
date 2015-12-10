# Project-Ceph
## "Fundamentals of storage technology"
### Saint-Petersburg Electrotechnical university. Saint-Petersburg 2015.
#### Contributors
  * Max Kanushin
  * Denis Korobov
  * Anton Tomilov
 
## Launch instructions

1. Install the following packages on your system:
  * vagrant
  * virtualbox
2. Go to the project directory
3. Execute
```sh
$ vagrant up
```
Vagrant will download server and client boxes and deploy them.

#### Server and client should be working at this point

You will now be able to log in into client (or server if you wish) using 
  * **username** *vagrant*
  * **password** *vagrant*

To connect to the server **after client reboot** execute the following commands on a client side:
```sh
$ sudo rbd map foo --pool rbd --name client.admin -c /etc/ceph/ceph.conf
$ sudo mount -t xfs /dev/rbd0 ceph_drive/
```
