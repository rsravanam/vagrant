Work around for Vagrant access outside.
Vagrant by default picks NAT and Bridge adaptors and assign a provate ip 10.0.2.15

If we need to access the app installed on vagrant we need to configure

config.vm.network "private_network", type: 'dhcp'

private network and dhcp is required.

User Virtual Box provider 

Hyper-v should be disabled.


