#!/bin/bash
clear
#color
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Loading..."
IZIN=$( curl https://raw.githubusercontent.com/Annnjayy/sc/main/name | grep $MYIP )
if [ $MYIP = $IZIN ]; then
echo -e "[ ${green}INFO${NC} ] Permission Accepted..."
else
echo -e "[ ${green}INFO${red} ] Permission Denied!${NC}";
echo -e "[ ${green}INFO${NC} ] Please Contact Admin!!"
echo -e "[ ${green}INFO${NC} ] WhatsApp : 087844547312"
echo -e "[ ${green}INFO${NC} ] Telegram : https://t.me/MakhlukVpn"
exit 0
fi
clear
# Getting
domain=$(cat /etc/xray/domain)
nsdomain=$(cat /etc/xray/dns)
key=$(cat /etc/slowdns/server.pub)
echo -e "===============================" | lolcat
read -p " Username : " Login
read -p " Password : " Pass
read -p " Expired (Days): " masaaktif
echo -e "===============================" | lolcat
sleep 1
echo -e "Running..."
sleep 1
clear
IP=$(wget -qO- ipinfo.io/ip);
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
expi="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
hariini=`date -d "0 days" +"%Y-%m-%d"`
expi=`date -d "$masaaktif days" +"%Y-%m-%d"`
clear
echo -e ""
echo -e "==============================================" | lolcat
echo -e "    Informasi SSH & OpenVPN    "
echo -e "==============================================" | lolcat
echo -e "Domain     : $domain"
echo -e "Username   : $Login"
echo -e "Password   : $Pass"
echo -e "Nameserver : $nsdomain"
echo -e "Public Key : $key"
echo -e "Created    : $hariini"
echo -e "Expired    : $expi"
echo -e "==============================================" | lolcat
echo -e "        Port Information       "
echo -e "==============================================" | lolcat
echo -e "OpenSSH      : 22, 443"
echo -e "Dropbear     : 109, 143, 443 "
echo -e "SLOWDNS      : 53"
echo -e "SSL/TLS      : 443, 445, 777"
echo -e "SSH WS SSL   : 443"
echo -e "SSH WS NTLS  : 8880 "
echo -e "OVPN WS SSL  : 2086, 990"
echo -e "OVPN TCP UDP : 1194, 2200"
echo -e "OHP SSH      : 8181"
echo -e "OHP Dropbear : 8282"
echo -e "OHP OpenVPN  : 8383"
echo -e "=============================================" | lolcat
echo -e "OVPN CONFIG  : http://$domain:89/OpenVPN.zip"
echo -e "Bad UDPGW    : 7100-7200-7300"
echo -e "=============================================" | lolcat
echo -e "   Payload Websocket SSL/TLS "
echo -e "=============================================" | lolcat
echo -e "GET wss://bug.com [protocol][crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "=============================================" | lolcat
echo -e "    Payload Websocket NTLS "
echo -e "=============================================" | lolcat
echo -e "GET / HTTP/1.1[crlf]Host: ${domain}[crlf]Upgrade: websocket[crlf][crlf]"
echo -e "==============================================" | lolcat
echo -e "             Script By MakhlukVpn          "
echo -e "==============================================" | lolcat
echo -e ""
echo -e "               Terimakasih Telah "
echo -e "            Menggunakan Layanan Kami "
echo -e ""
echo -e "==============================================" | lolcat
echo -e ""

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
