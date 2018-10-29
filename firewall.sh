#!/bin/bash

# Set default policies
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

# Allow loopback traffic
iptables -I INPUT -i lo -j ACCEPT

# PING
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# DNS
iptables -A INPUT -p tcp --dport 1812 --sport 1812 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 1812 --dport 1812 -j ACCEPT

# DHCP
iptables -I INPUT -p udp --dport 67:68 --sport 67:68 -j ACCEPT

# Eth SSH maintenance
iptables -I INPUT -i eth0 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Nos defendemos del mundo
iptables -I INPUT -i wlan0 -j REJECT

# Permitir conexciones establecidas
#iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
