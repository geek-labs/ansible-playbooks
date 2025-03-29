
# TODO: masq
#node.default[:shorewall][:snat].push(
#  { "action": 'MASQUERADE', "dest": 'enp9s0', "source": '10.1.0.0/24' }
#)
# TODO: either firewalld or proxmox internal firewall https://pve.proxmox.com/pve-docs/pve-admin-guide.html#chapter_pve_firewall

#- ansible.posix.sysctl:
#    name: net.ipv4.ip_forward
#    value: '1'
#    sysctl_set: true
