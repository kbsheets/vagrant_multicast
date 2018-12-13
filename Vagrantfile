# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  required_plugins = %w( vagrant-vbguest vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
      unless Vagrant.has_plugin? plugin
              system "vagrant plugin install #{plugin}"
              _retry=true
      end
  end

  if (_retry)
          exec "vagrant " + ARGV.join(' ')
  end

  config.vm.box = "centos/7"
  config.vm.provider :virtualbox do |v|
          v.memory = 4096
          v.cpus = 2
          v.linked_clone = true
  end

  (1..2).each do |i|
          config.vm.define "node-#{i}" do |node|
                  node.vm.hostname = "node-#{i}"
                  node.vm.network "private_network", ip: "192.168.2.1#{i}", bootproto: "static"
                  node.vm.provision :shell, path: "setup.sh", privileged: false
          end
  end
end

