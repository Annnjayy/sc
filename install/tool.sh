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
# info
echo -e "===============================" | lolcat
echo -e "      Installing All Tool      "
echo -e "===============================" | lolcat
sleep 1
echo -e "[ ${green}INFO${NC} ] Starting Install Tools..... " 
sleep 1
# Link Hosting Kalian Untuk Tool
ssh="raw.githubusercontent.com/Annnjayy/sc/main/ssh"
# Link Hosting Kalian Untuk Xray
xray="raw.githubusercontent.com/Annnjayy/sc/main/xray"
# Link Hosting Kalian Untuk Service
service="raw.githubusercontent.com/Annnjayy/sc/main/service"
# Link Hosting Kalian Untuk Menu
menu="raw.githubusercontent.com/Annnjayy/sc/main/menu"
#Link Hosting Kalian Untuk Install
instal="raw.githubusercontent.com/Annnjayy/sc/main/install"
#install
cd /usr/bin
wget --output-document=limit "https://${menu}/limitspeed.sh"
wget --output-document=slhost "https://${service}/cf.sh"
wget --output-document=about "https://${menu}/about.sh"
wget --output-document=menu "https://${menu}/menu.sh"
wget --output-document=usernew "https://${ssh}/usernew.sh"
wget --output-document=renew "https://${ssh}/renew.sh"
wget --output-document=trial "https://${ssh}/trial.sh"
wget --output-document=delete "https://${ssh}/delete.sh"
wget --output-document=member "https://${ssh}/member.sh"
wget --output-document=st "https://${menu}/running.sh"
wget --output-document=restart "https://${menu}/restart.sh"
wget --output-document=usernew "https://${ssh}/usernew.sh"
wget --output-document=autokill "https://${ssh}/autokill.sh"
wget --output-document=ceklim "https://${ssh}/ceklim.sh"
wget --output-document=cek "https://${ssh}/cekssh.sh"
wget --output-document=tendang "https://${service}/tendang.sh"
wget --output-document=clearlog "https://${service}/clearlog.sh"
wget --output-document=xp "https://${service}/xp.sh"
wget --output-document=addvmess "https://${xray}/addvmess.sh"
wget --output-document=addvless "https://${xray}/addvless.sh"
wget --output-document=addtrojan "https://${xray}/addtrojan.sh"
wget --output-document=backup "https://${menu}/backup.sh"
wget --output-document=restore "https://${menu}/restore.sh"
wget --output-document=menu-tro "https://${menu}/menu-trojan.sh"
wget --output-document=menu-ssh "https://${menu}/menu-ssh.sh"
wget --output-document=menu-cf "https://${menu}/menu-cf.sh"
wget --output-document=menu-xray "https://${menu}/menu-xray.sh"
wget --output-document=menu-cloud "https://${menu}/menu-cloud.sh"
wget --output-document=delvmess "https://${xray}/delvmess.sh"
wget --output-document=delvless "https://${xray}/delvless.sh"
wget --output-document=deltrojan "https://${xray}/deltrojan.sh"
wget --output-document=cekvmess "https://${xray}/cekvmess.sh"
wget --output-document=cekvless "https://${xray}/cekvless.sh"
wget --output-document=cektrojan "https://${xray}/cektrojan.sh"
wget --output-document=renewvmess "https://${xray}/renewvmess.sh"
wget --output-document=renewvless "https://${xray}/renewvless.sh"
wget --output-document=renewtrojan "https://${xray}/renewtrojan.sh"
wget --output-document=addtrgo "https://${xray}/addtrgo.sh"
wget --output-document=cektrgo "https://${xray}/cektrgo.sh"
wget --output-document=deltrgo "https://${xray}/deltrgo.sh"
wget --output-document=renewtrgo "https://${xray}/renewtrgo.sh"
wget --output-document=certv2ray "https://${menu}/certv2ray.sh"
wget --output-document=ipsaya "https://${service}/ipsaya.sh"
chmod +x backup
chmod +x restore
chmod +x ipsaya
chmod +x menu-xray
chmod +x menu-tro
chmod +x menu-cloud
chmod +x menu-ssh
chmod +x menu-cf
chmod +x limit
chmod +x cek
chmod +x slhost
chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x delete
chmod +x member
chmod +x restart
chmod +x about
chmod +x autokill
chmod +x tendang
chmod +x ceklim
chmod +x renew
chmod +x clearlog
chmod +x xp
chmod +x addvmess
chmod +x addvless
chmod +x addtrojan
chmod +x addtrgo
chmod +x delvmess
chmod +x delvless
chmod +x deltrojan
chmod +x deltrgo
chmod +x cekvmess
chmod +x cekvless
chmod +x cektrojan
chmod +x cektrgo
chmod +x renewvmess
chmod +x renewvless
chmod +x renewtrojan
chmod +x renewtrgo
chmod +x certv2ray
#fix
echo "0 5 * * * root clearlog && reboot" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
echo "10 4 * * * root clearlog && sslh-fix-reboot" >> /etc/crontab
echo "0 0 * * * root clearlog && reboot" >> /etc/crontab
echo "0 12 * * * root clearlog && reboot" >> /etc/crontab
echo "0 18 * * * root clearlog && reboot" >> /etc/crontab
#hapus sc
rm /root/tool.sh
