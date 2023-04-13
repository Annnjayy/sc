#!/bin/bash
clear
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/v2ray-tls.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo -e "===============================" | lolcat
		echo -e "  You have no existing clients!"
		exit 1
	fi

	clear
	echo " Select the existing client you want to remove"
	echo " Press CTRL+C to return"
	echo -e "===============================" | lolcat
	echo "         No  Expired   User"
	echo -e "===============================" | lolcat
	grep -E "^### " "/etc/xray/v2ray-tls.json" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Select one client [1]: " CLIENT_NUMBER
		else
			read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
user=$(grep -E "^### " "/etc/xray/v2ray-tls.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/v2ray-tls.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/v2ray-tls.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/v2ray-nontls.json
rm -f /etc/xray/v2ray-$user-tls.json /etc/xray/v2ray-$user-nontls.json
systemctl restart xray@v2ray-tls
systemctl restart xray@v2ray-nontls
clear
echo ""
echo -e "===============================" | lolcat
echo -e "  XRAYS/Vmess Account Deleted     "
echo -e "===============================" | lolcat
echo -e "  Username  : $user"
echo -e "  Expired   : $exp"
echo -e "===============================" | lolcat
echo -e "      Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
