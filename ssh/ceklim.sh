#!/bin/bash
clear
echo " "
if [ -e "/root/log-limit.txt" ]; then
echo -e "===============================" | lolcat
echo -e " User Who Violate The Maximum "
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
cat /root/log-limit.txt
else
echo -e "===============================" | lolcat
echo -e "    No User Multi Login or"                  
echo -e "  The User-Limit Not Executed"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
fi

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
