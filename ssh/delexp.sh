#!/bin/bash
clear
red='\e[1;31m'
green='\e[0;32m'
clear
# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
hariini=`date +%d-%m-%Y`
echo -e "===============================" | lolcat
echo -e "          Succesfully
echo -e "===============================" | lolcat
echo -e " Username $hariini Telah Di Hapus"
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn          "
echo -e "===============================" | lolcat
cat /etc/shadow | cut -d: -f1,8 | sed /:$/d > /tmp/expirelist.txt
totalaccounts=`cat /tmp/expirelist.txt | wc -l`
for((i=1; i<=$totalaccounts; i++ ))
do
tuserval=`head -n $i /tmp/expirelist.txt | tail -n 1`
username=`echo $tuserval | cut -f1 -d:`
userexp=`echo $tuserval | cut -f2 -d:`
userexpireinseconds=$(( $userexp * 86400 ))
tglexp=`date -d @$userexpireinseconds`             
tgl=`echo $tglexp |awk -F" " '{print $3}'`
while [ ${#tgl} -lt 2 ]
do
tgl="0"$tgl
done
while [ ${#username} -lt 15 ]
do
username=$username" " 
done
bulantahun=`echo $tglexp |awk -F" " '{print $2,$6}'`
echo "echo "Expired- User : $username Expire at : $tgl $bulantahun"" >> /usr/local/bin/alluser
todaystime=`date +%s`
if [ $userexpireinseconds -ge $todaystime ] ;
then
:
else
echo "echo "Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini "" >> /usr/local/bin/deleteduser
echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
userdel $username
fi
done
echo -e "===============================" | lolcat
echo -e "          Succesfully
echo -e "===============================" | lolcat
echo -e "      Script By MakhlukVpn       "
echo -e "===============================" | lolcat

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
