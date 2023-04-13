#!/bin/bash
clear
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "===============================" | lolcat
read -p "  Username SSH to Delete : " Pengguna
if getent passwd $Pengguna > /dev/null 2>&1; then
userdel $Pengguna
echo -e "===============================" | lolcat
echo -e "          Succesfully "
echo -e "===============================" | lolcat
echo -e "  Username $Pengguna Telah Di Hapus"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn  "
echo -e "===============================" | lolcat
fi

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
