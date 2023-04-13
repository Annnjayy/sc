#!/bin/bash
clear
# Color
RED='\033[0;31m'
NC='\033[0m'
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo -n > /tmp/other.txt
data=( `cat /etc/trojan-go/akun.conf | grep '^###' | cut -d ' ' -f 2`);
echo -e "===============================" | lolcat
echo -e "     Trojan GO User Login            "
echo -e "===============================" | lolcat
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/iptrojango.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp6 | grep trojan-go | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/trojan-go/trojan-go.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/iptrojango.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/iptrojango.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/iptrojango.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/iptrojango.txt | nl)
echo "user : $akun";
echo "$jum2";
echo -e "===============================" | lolcat
fi
rm -rf /tmp/iptrojango.txt
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
echo "other";
echo "$oth";
echo -e "===============================" | lolcat
echo -e "      Script By MakhlukVpn"
echo -e "===============================" | lolcat
rm -rf /tmp/other.txt

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
