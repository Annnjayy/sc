#!/bin/bash
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d")
domain=$(cat /etc/xray/domain)
clear
echo "Starting Backup"
sleep 1
echo "Membuat Directory"
mkdir /root/backup
sleep 1
echo "Start Backup"
sleep 2
clear
cp /etc/passwd backup/
cp /etc/group backup/
cp -r /etc/xray backup/xray
cp -r /etc/trojan-go backup/trojan-go
cp -r /home/vps/public_html backup/public_html
cd /root/backup
zip -r backup-$date.zip 
mv backup-$date.zip /home/vps/public_html
link="http://$domain:89/backup-$date.zip"
echo -e "The following is a link to your vps data backup file."
echo -e "===============================" | lolcat
echo -e "        Detail Backup   "
echo -e "===============================" | lolcat
echo -e " Ip VPS        : $IP"
echo -e " Domain VPS    : $domain"
echo -e " Link Backup   : $link"
echo -e "===============================" | lolcat
echo -e "      Script By MakhlukVpn"
echo -e "===============================" | lolcat
echo ""
echo -e "If you want to restore data, please copy the link above"
echo ""
cd
rm -rf /root/backup
rm -r /root/backup-$date.zip
echo "Done"

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
