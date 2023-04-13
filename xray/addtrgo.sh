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
uuid=$(cat /etc/trojan-go/uuid.txt)
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		echo -e "===============================" | lolcat
		read -rp "Password : " -e user
		user_EXISTS=$(grep -w $user /etc/trojan-go/akun.conf | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo ""
			echo -e "Username ${red}${user}${NC} Already On VPS Please Choose Another"
			exit 1
		fi
	done
read -p "Expired (Days) : " masaaktif
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan-go/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
hariini=`date -d "0 days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan-go/akun.conf
systemctl restart trojan-go.service
link="trojan-go://${user}@${domain}:2053/?sni=${domain}&type=ws&host=${domain}&path=/trojango&encryption=none#$user"
clear
echo -e ""
echo -e "======={XRAYS/TROJAN-GO}=======" | lolcat
echo -e "Remarks    : ${user}"
echo -e "Address    : ${domain}"
echo -e "Port       : 2053"
echo -e "Key        : ${user}"
echo -e "Encryption : none"
echo -e "Path       : /trojango"
echo -e "Created    : $hariini"
echo -e "Expired    : $exp"
echo -e "===============================" | lolcat
echo -e "Link Tr Go : ${link}"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
echo -e "       Terimakasih Telah "
echo -e "    Menggunakan Layanan Kami "
echo -e ""
echo -e "===============================" | lolcat
echo -e ""

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
