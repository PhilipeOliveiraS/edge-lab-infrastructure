# RouterOS 7.23.7 (long-term) - Sanitized Configuration Blueprint
# Model: RB3011UiAS-RM
# Note: Sensitive secrets, MAC addresses, and credentials removed.

/interface bridge
add name=bridge-lan

/interface list
add name=WAN
add name=LAN

/interface list member
add interface=ether1 list=WAN
add interface=bridge-lan list=LAN

/ip pool
add name=dhcp-pool-lan ranges=192.168.88.10-192.168.88.254

/ip dhcp-server
add address-pool=dhcp-pool-lan interface=bridge-lan name=defconf

/ip dhcp-server network
add address=192.168.88.0/24 dns-server=192.168.88.1 gateway=192.168.88.1

/ip address
add address=192.168.88.1/24 interface=bridge-lan network=192.168.88.0

/ip dhcp-client
add interface=ether1 use-peer-dns=yes use-peer-ntp=yes

/ip firewall filter
add action=accept chain=input connection-state=established,related
add action=drop chain=input connection-state=invalid
add action=accept chain=input protocol=icmp
add action=accept chain=input dst-port=22,8291 in-interface-list=WAN protocol=tcp src-address=192.168.7.58 comment="Admin Workstation Only"
add action=drop chain=input in-interface-list=!LAN comment="Drop non-LAN input"

/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
add action=dst-nat chain=dstnat dst-port=2222 in-interface=ether1 protocol=tcp src-address=192.168.7.58 to-addresses=192.168.88.2 to-ports=22 comment="DNAT to Cisco Site A"
