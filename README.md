## Description
Just a little Vagrantfile I wrote to help with CTF PCAP forensics challenges.

## Installation
1. Install vagrant and virtualbox
2. Clone the repo
3. Run `vagrant up`

## Usage
1. Once the box has finished installing and configuring, copy a pcap to this directory.
2. Log into the box with `vagrant ssh`
3. Load the pcap using `moloch-capture -r /vagrant/FILE.pcap`. Don't delete or move the pcap because it still needs to be readable at this path.
4. Point your browser to http://localhost:8005
