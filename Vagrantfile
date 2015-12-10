Vagrant::Config.run do |config|
config.vm.customize ["modifyvm", :id, "--nictype1", "virtio"]
  config.vm.define :ceph do |ceph|
    ceph.vm.box = "ceph-server"
	ceph.vm.box_url = "https://www.dropbox.com/s/6a3p7wpp5yn4jz6/ceph-all-in-one.box?dl=1"
    ceph.vm.network :hostonly, "192.168.251.100", { :nic_type => 'virtio' }
    ceph.vm.host_name = "ceph"
  end
  config.vm.define :client do |client|
    client.vm.box = "ubuntu"
	client.vm.box_url = "https://www.dropbox.com/s/r60phhfpsr8e9ed/precise64.box?dl=1"
    client.vm.host_name = "ceph-client"
    client.vm.network :hostonly, "192.168.251.101", { :nic_type => 'virtio' }
    client.vm.provision :shell, :path => "setup/ceph.sh"
  end
end
