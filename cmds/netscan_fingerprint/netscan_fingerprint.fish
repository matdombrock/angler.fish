#!/usr/bin/env fish

echo nmap:
nmap -sV -O $argv[1]
echo arp:
arp-fingerprint $argv[1]
