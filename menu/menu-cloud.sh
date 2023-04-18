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
echo -e "===============================" | lolcat
echo -e "     ⇱ Menu Vps Manager ⇲ "        
echo -e "===============================" | lolcat
echo -e " 1}. Backup Data VPS"
echo -e " 2}. Restore Data VPS"
echo -e " 3}. Info Load Vps"
echo -e " 4}. Menu"
echo -e " x}. Exit"
echo -e ""
echo -e ""
echo -e "===============================" | lolcat
read -p "    Select From Options [ 1 - 4 or [x] ] : " menu
echo -e "===============================" | lolcat
case $menu in
1)
backup
;;
2)
restore
;;
3)
gotop
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
;;
4)
menu
;;
x)
exit
;;
esac
