set -e

hostnamectl set-hostname moloch-vm

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get upgrade -y
apt-get install -y apt-transport-https software-properties-common wget jq openjdk-11-jdk python3-pip

# install elastic repo
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list

# no moloch repo so dl a deb directly
MOLOCH_VER=$(curl -sL https://api.github.com/repos/aol/moloch/tags | jq -r .[0].name | tr -d "v")

echo "Downloading moloch ${MOLOCH_VER}"
wget --no-verbose https://s3.amazonaws.com/files.molo.ch/builds/ubuntu-20.04/moloch_${MOLOCH_VER}-1_amd64.deb

apt-get update
apt-get install -y elasticsearch ./moloch_${MOLOCH_VER}-1_amd64.deb

pip3 install ansible

ansible-playbook /vagrant/ansible/all.yml

echo "Save PCAPs into this dir then run 'vagrant ssh' to log into the VM"
echo "This dir will be mounted to /vagrant in the VM"
echo "To load PCAPs into Moloch, run:"
echo "    moloch-capture -r <PCAP>"
echo "Log into moloch at http://localhost:8005"
