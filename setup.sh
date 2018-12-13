#!/bin/bash
sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y ansible
sudo yum install -y git
sudo yum install -y iperf

ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/id_rsa.pub
git clone https://github.com/kbsheets/multicast_setup /tmp/multicast_setup
cd /tmp/multicast_setup

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventories/test ./enable_multicast.yml
