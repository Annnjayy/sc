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
# isp
NAMAISP=$( curl -s ipinfo.io/org | cut -d " " -f 2-10  )
COUNTRY=$( curl -s ipinfo.io/country )
Name="$(cat /root/.s/pengguna)"
Kata="$(curl https://raw.githubusercontent.com/Annnjayy/sc/main/service/kata)"
# os
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID
# Getting CPU Information
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
# Total Ram
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))
# Ram Usage
total_r2am=` grep "MemAvailable: " /proc/meminfo | awk '{ print $2}'`
MEMORY=$(($total_r2am/1024))
# Getting Domain Name
MYIP=$(wget -qO- icanhazip.com);
Domen="$(cat /etc/xray/domain)"
# Download
download=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev  | awk '{print $2}' | paste -sd+ - | bc`
downloadsize=$(($download/1073741824))
# Upload
upload=`grep -e "lo:" -e "wlan0:" -e "eth0" /proc/net/dev | awk '{print $10}' | paste -sd+ - | bc`
uploadsize=$(($upload/1073741824))
clear
echo -e ""
echo -e "=====================================" | lolcat
echo -e "        ⇱ Sytem Information ⇲         "
echo -e "=====================================" | lolcat
echo -e "• OS Name     : $Tipe , $Versi_OS"
echo -e "• Cpu Usage   : $cpu_usage"
echo -e "• Total RAM   : ${totalram}MB"
echo -e "• Avaible     : ${MEMORY}MB"
echo -e "• Public IP   : $MYIP"
echo -e "• Domain      : $Domen"
echo -e "• ISP Country : $NAMAISP , $COUNTRY"
echo -e "=====================================" | lolcat
echo -e "          ⇱ Menu Manager ⇲ "        
echo -e "=====================================" | lolcat
echo -e ""
echo -e " 1}.$green  Manage SSH & OpenVPN"
echo -e " 2}.$green  Manage X-RAY Vmess & Vless"
echo -e " 3}.$green  Manage X-RAY Trojan GFW & Go"
echo -e " 4}.$green  Restart All Service"
echo -e " 5}.$green  Manage Cloudflare Domain"
echo -e " 6}.$green  Renew Certificate Xray"
echo -e " 7}.$green  Manage Limit Bandwidth "
echo -e " 8}.$green  Info Script & Service"
echo -e " 9}.$green  Manage Cloud & load Vps"
echo -e " 10}.$green Reboot Vps "
echo -e " x}.$red  Exit"
echo -e ""
echo -e "=====================================" | lolcat
echo -e "• Total Download : $downloadsize GB "
echo -e "• Total Upload   : $uploadsize GB "
echo -e "• Client Name    : $Name"
echo -e "• Exp Script     : LifeTime"
echo -e "• Version        : V.1 {latest}"
echo -e "=====================================" | lolcat
echo -e "        Script By MakhlukVpn      "
echo -e "=====================================" | lolcat
echo -e ""
echo -e " Quote : $Kata"
echo -e ""
echo -e "=====================================" | lolcat
read -p " Please Input Number  [1-10 or [x] ] :  "  menu
echo -e "=====================================" | lolcat
case $menu in
1)
menu-ssh
;;
2)
menu-xray
;;
3)
menu-tro
;;
4)
restart
;;
5)
menu-cf
;;
6)
certv2ray
;;
7)
limit
;;
8)
about
;;
9)
menu-cloud
;;
10)
reboot
;;
x)
exit
;;
esac
