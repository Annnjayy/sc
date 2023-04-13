#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
clear
# Getting
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
domain=$(cat /etc/xray/domain)
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
echo -e "[ ${green}INFO${NC} ] Starting Install Cert..... " 
sleep 0.5
systemctl enable xray@v2ray-tls
systemctl enable xray@v2ray-nontls
systemctl enable xray@vless-tls
systemctl enable xray@vless-nontls
systemctl enable xray@trojan
systemctl stop $STOPWEBSERVER
systemctl stop nginx
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
systemctl restart xray@trojan
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
