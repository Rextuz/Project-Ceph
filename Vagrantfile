Vagrant::Config.run do |config|
config.vm.customize ["modifyvm", :id, "--nictype1", "virtio"]
  config.vm.define :ceph do |ceph|
    ceph.vm.box = "ceph-server"
	ceph.vm.box_url = "https://www.dropbox.com/s/6a3p7wpp5yn4jz6/ceph-all-in-one.box?dl=1"
    ceph.vm.network :hostonly, "192.168.251.100", { :nic_type => 'virtio' }
    ceph.vm.host_name = "ceph"
  end
  config.vm.define :client1 do |client1|
    client1.vm.box = "client1"
	client1.vm.box_url = "https://www.dropbox.com/s/r60phhfpsr8e9ed/precise64.box?dl=1"
    client1.vm.host_name = "ceph-client1"
    client1.vm.network :hostonly, "192.168.251.101", { :nic_type => 'virtio' }
    client1.vm.provision :shell, :path => "setup/ceph.sh", :args => "1"
  end
  config.vm.define :client2 do |client2|
    client2.vm.box = "client2"
	client2.vm.box_url = "https://www.dropbox.com/s/r60phhfpsr8e9ed/precise64.box?dl=1"
    client2.vm.host_name = "ceph-client2"
    client2.vm.network :hostonly, "192.168.251.102", { :nic_type => 'virtio' }
    client2.vm.provision :shell, :path => "setup/ceph.sh"
  end
end
