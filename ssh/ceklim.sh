#!/bin/bash
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
echo " "
if [ -e "/root/log-limit.txt" ]; then
echo -e "===============================" | lolcat
echo -e "User Who Violate The Maximum Limit"
echo -e "Time - Username - Number of Multilogin"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
cat /root/log-limit.txt
else
echo -e "===============================" | lolcat
echo -e "  No user has committed a violation"
echo -e "                  or"
echo -e " The user-limit script not been executed"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
fi
