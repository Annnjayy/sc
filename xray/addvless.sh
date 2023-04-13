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
MYIP=$(wget -qO- ipinfo.io/ip);
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		echo -e "===============================" | lolcat
		read -rp "Username : " -e user
		CLIENT_EXISTS=$(grep -w $user /etc/xray/vless-tls.json | wc -l)

		if [[ ${CLIENT_EXISTS} == '1' ]]; then
			echo -e "===============================" | lolcat
			echo -e "Username ${red}${user}${NC} Already On VPS Please Choose Another"
			echo -e "===============================" | lolcat
			exit 1
		fi
	done
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (Days) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-vless-tls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vless-tls.json
sed -i '/#xray-vless-nontls$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/vless-nontls.json
xrayvless1="vless://${uuid}@${domain}:2083?path=/vless&security=tls&encryption=none&type=ws#${user}"
xrayvless2="vless://${uuid}@${domain}:2095?path=/vless&encryption=none&type=ws#${user}"
systemctl restart xray@vless-tls
systemctl restart xray@vless-nontls
service cron restart
clear
echo -e ""
echo -e "========={XRAYS/VLESS}==========" | lolcat
echo -e "Remarks     : ${user}"
echo -e "Address     : ${domain}"
echo -e "Port TLS    : 2083"
echo -e "Port NTLS   : 2095"
echo -e "User ID     : ${uuid}"
echo -e "Encryption  : none"
echo -e "Network     : ws"
echo -e "Path        : /vless"
echo -e "Created     : $hariini"
echo -e "Expired     : $exp"
echo -e "===============================" | lolcat
echo -e "Link TLS  : ${xrayvless1}"
echo -e "===============================" | lolcat
echo -e "Link NTLS : ${xrayvless2}"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
echo -e "      Terimakasih Telah "
echo -e "    Menggunakan Layanan Kami "
echo -e ""
echo -e "===============================" | lolcat
echo -e ""

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
