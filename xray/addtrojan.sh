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
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
		echo -e "===============================" | lolcat
		read -rp "Password : " -e user
		user_EXISTS=$(grep -w $user /etc/xray/trojan.json | wc -l)

		if [[ ${user_EXISTS} == '1' ]]; then
			echo -e "===============================" | lolcat
			echo -e "Username ${red}${user}${NC} Already On VPS Please Choose Another"
			echo -e "===============================" | lolcat
			exit 1
		fi
	done
read -p "Expired (Days) : " masaaktif
echo -e "===============================" | lolcat
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#xray-trojan$/a\### '"$user $exp"'\
},{"password": "'""$user""'","email": "'""$user""'"' /etc/xray/trojan.json
systemctl restart xray@trojan
trojanlink="trojan://${user}@${domain}:2087"
service cron restart
clear
echo -e ""
echo -e "========={XRAYS/TROJAN-GFW}=========" | lolcat
echo -e "Remarks  : ${user}"
echo -e "Address  : ${domain}"
echo -e "Port     : 2087"
echo -e "Key      : ${user}"
echo -e "Created  : $hariini"
echo -e "Expired  : $exp"
echo -e "===============================" | lolcat
echo -e "Link TR GFW : ${trojanlink}"
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
