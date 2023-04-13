#!/bin/bash
clear
echo "This Feature Can Only Be Used According To Vps Data With This Autoscript"
echo "Please input link to your vps data backup file."
echo -e "===============================" | lolcat
echo -e "  Mohon Masukan Link Backup  "        
echo -e "===============================" | lolcat
read -rp " Link File Backup : " -e url
echo -e "===============================" | lolcat
wget --output-document=backup.zip "$url"
unzip backup.zip
rm -f backup.zip
sleep 1
echo Start Restore
cd /root/backup
cp passwd /etc/
cp group /etc/
cp -r xray /etc/
cp -r trojan-go /etc/
cp -r public_html /home/vps/
cp crontab /etc/
strt
rm -rf /root/backup
rm -f backup.zip
echo -e "===============================" | lolcat
echo -e "      Restore Succesfully "
echo -e "===============================" | lolcat
echo -e "    Script By MakhlukVpn          "
echo -e "===============================" | lolcat

read -n 1 -s -r -p "Press [ Enter ] to back on menu"

menu
