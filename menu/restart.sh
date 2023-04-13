#!/bin/bash
clear
#color
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
echo -e ""
echo -e "================================" | lolcat
echo -e "  Starting Restart All Service"
echo -e "================================" | lolcat
sleep 1
echo -e "[ ${green}INFO${NC} ] Starting Restart Service... " 
sleep 0.5
pkill python
systemctl daemon-reload
echo -e "[ ${green}INFO${NC} ] Starting Restart Ohp... " 
sleep 0.5
systemctl restart ssh-ohp
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp
echo -e "[ ${green}INFO${NC} ] Starting Restart Websocket..." 
sleep 0.5
systemctl restart ws-tls
systemctl restart ws-nontls
echo -e "[ ${green}INFO${NC} ] Starting Restart Xray... " 
sleep 0.5
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
systemctl restart xray@trojan
systemctl restart trojan-go
systemctl restart dns
echo -e "[ ${green}INFO${NC} ] Starting Restart Ssh... " 
sleep 0.5
/etc/init.d/ssh restart
/etc/init.d/sslh restart
echo -e "[ ${green}INFO${NC} ] Starting Restart Dropbear... " 
sleep 0.5
/etc/init.d/dropbear restart
echo -e "[ ${green}INFO${NC} ] Starting Restart Stunnel... " 
sleep 0.5
/etc/init.d/stunnel5 restart
echo -e "[ ${green}INFO${NC} ] Starting Restart OpenVPN... " 
sleep 0.5
/etc/init.d/openvpn restart
systemctl restart ws-ovpn
echo -e "[ ${green}INFO${NC} ] Starting Restart Fail2ban " 
sleep 0.5
/etc/init.d/fail2ban restart
echo -e "[ ${green}INFO${NC} ] Starting Restart Cron... " 
sleep 0.5
/etc/init.d/cron restart
echo -e "[ ${green}INFO${NC} ] Starting Restart Nginx... " 
sleep 0.5
/etc/init.d/nginx restart
echo -e "[ ${green}INFO${NC} ] Starting Restart SlowDNS... " 
sleep 0.5
systemctl restart rc-local > /root/.s/log
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000 
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
echo -e "================================" | lolcat
echo -e "  Restart All Service Berhasil"
echo -e "================================" | lolcat
echo -e "     Script By MakhlukVpn      "
echo -e "================================" | lolcat
echo -e ""

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
