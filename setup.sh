#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
#color
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- ipinfo.io/ip);
echo -e "[ ${green}INFO${NC} ] Starting Check Ip Vps... " 
sleep 2
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
# Disable Ipv6
echo -e "[ ${green}INFO${NC} ] Starting Disable Ipv6 " 
sleep 2
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
#update
echo -e "[ ${green}INFO${NC} ] Starting Install Package " 
sleep 2
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt install lolcat -y
# Install Requirements Tools
apt install openssl iptables iptables-persistent -y
apt-get install ncurses-utils -y
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install net-tools -y
apt install gnupg1 -y
apt install jq -y
apt install build-essential -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y
# info script install
if [ -f "/etc/.s/log-install.txt" ]; then
echo -e "===============================" | lolcat
echo -e "   Script Already Installed"
echo -e "===============================" | lolcat
exit 0
fi
# Install script
echo "====================================" | lolcat
echo "     Installing AutoScript            "
echo "====================================" | lolcat
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting Install Script.... " 
sleep 0.5
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
# Nama pengguna
mkdir .s
mkdir /etc/xray
mkdir /usr/sbin
echo -e "===============================" | lolcat
read -rp " Nama/Pengguna : " -e nama
echo -e "===============================" | lolcat
echo $nama > /root/.s/pengguna
mkdir /var/lib/crot;
echo "IP=" >> /var/lib/crot/ipvps.conf
# install cloudflare certificate
echo -e "[ ${green}INFO${NC} ] Starting Getting Cert... "
sleep 2
function add_dm() {
    echo -e "===============================" | lolcat
    echo "1. Use Domain From Script / Gunakan Domain Dari Script"
    echo "2. Choose Your Own Domain / Pilih Domain Sendiri"
    echo -e "===============================" | lolcat
    read -rp "Choose Your Domain Installation : " dom 

    if test $dom -eq 1; then
    clear
    apt install jq curl -y
    wget --output-document=/root/.s/cf "${service}/cf.sh" >/dev/null 2>&1
    chmod +x /root/.s/cf
    bash /root/.s/cf
    print_success "DomainAll"
    elif test $dom -eq 2; then
    read -rp "Enter Your Domain : " domen 
    echo $domen > /root/domain
    mv /root/domain /etc/xray/domain
    else 
    echo "Not Found Argument"
    exit 1
    fi
    echo -e "${GREEN}Done!${NC}"
    sleep 2
    clear
}
function ins_ssl() {
    print_install "Memasang SSL pada domain"
    domain=$(cat /root/domain)
    STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
    rm -rf /root/.acme.sh
    mkdir /root/.acme.sh
    systemctl stop $STOPWEBSERVER
    systemctl stop nginx
    curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
    chmod +x /root/.acme.sh/acme.sh
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
    chmod 777 /etc/xray/xray.key
    print_success "SSL Certificate"
}
add_dm
ins_ssl
# install xray
echo -e "[ ${green}INFO${NC} ] Starting Install Xray "
sleep 2
wget https://${instal}/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
#install all service
echo -e "[ ${green}INFO${NC} ] Starting Install All Service "
sleep 2
wget https://${instal}/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
# Websocket
echo -e "[ ${green}INFO${NC} ] Starting Install SSH Ws & OpenVPN & OHP "
sleep 2
wget https://${instal}/ssh-ws.sh && chmod +x ssh-ws.sh && ./ssh-ws.sh
# Ohp Server
wget https://${instal}/ohp.sh && chmod +x ohp.sh && ./ohp.sh
# install openvpn
wget https://${instal}/openvpn.sh && bash openvpn.sh
# install tool
echo -e "[ ${green}INFO${NC} ] Starting Install Tools "
sleep 2
wget https://${instal}/tool.sh && bash tool.sh
# install slowdns cloudflare certificate
wget https://${instal}/nscf.sh && bash nscf.sh
#service set
cat <<EOF> /etc/systemd/system/autosett.service
[Unit]
Description=autosetting
Documentation=nekopoi.care

[Service]
Type=oneshot
ExecStart=/bin/bash /etc/set.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable autosett
wget --output-document=/etc/set.sh "https://${service}/set.sh"
chmod +x /etc/set.sh
history -c
echo "1.2" > /home/ver
echo -e "[ ${green}INFO${NC} ] Processing Install Done "
sleep 2
echo " " | tee -a log-install.txt
echo "=========== {Service & Port} ===========" | tee -a log-install.txt | lolcat
echo " " | tee -a log-install.txt
echo "  - OpenSSH           : 22, 2253"  | tee -a log-install.txt
echo "  - OpenVPN TCP       : 1194"  | tee -a log-install.txt
echo "  - OpenVPN UDP       : 2200"  | tee -a log-install.txt
echo "  - OpenVPN SSL       : 990"  | tee -a log-install.txt
echo "  - Stunnel5          : 443, 445, 777"  | tee -a log-install.txt
echo "  - Dropbear          : 143, 109, 443"  | tee -a log-install.txt
echo "  - Squid Proxy       : 3128, 8080"  | tee -a log-install.txt
echo "  - Badvpn            : 7100, 7200, 7300"  | tee -a log-install.txt
echo "  - Nginx             : 89"  | tee -a log-install.txt
echo "  - X-Ray Vmess TLS   : 8443"  | tee -a log-install.txt
echo "  - X-Ray Vmess NTLS  : 80"  | tee -a log-install.txt
echo "  - X-Ray Vless TLS   : 2083"  | tee -a log-install.txt
echo "  - X-Ray Vless NTLS  : 2095"  | tee -a log-install.txt
echo "  - X-Ray Trojan GFW  : 2087"  | tee -a log-install.txt
echo "  - X-Ray Trojan GO   : 2053"  | tee -a log-install.txt
echo "  - Websocket TLS     : 443 "  | tee -a log-install.txt
echo "  - Websocket NTLS    : 8880 "  | tee -a log-install.txt
echo "  - Websocket Ovpn    : 2086"  | tee -a log-install.txt
echo "  - OHP SSH           : 8181"  | tee -a log-install.txt
echo "  - OHP Dropbear      : 8282"  | tee -a log-install.txt
echo "  - OHP OpenVPN       : 8383"  | tee -a log-install.txt
echo "  - SlowDNS           : 53, 5300 "  | tee -a log-install.txt
echo " " | tee -a log-install.txt
echo " {Server Information & Other Features} "  | tee -a log-install.txt | lolcat
echo " " | tee -a log-install.txt
echo "  - Timezone          : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "  - Fail2Ban          : [ON]"  | tee -a log-install.txt
echo "  - Dflate            : [ON]"  | tee -a log-install.txt
echo "  - IPtables          : [ON]"  | tee -a log-install.txt
echo "  - Auto-Reboot       : [ON]"  | tee -a log-install.txt
echo "  - IPv6              : [OFF]"  | tee -a log-install.txt
echo "  - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "  - Autobackup Data" | tee -a log-install.txt
echo "  - Restore Data" | tee -a log-install.txt
echo "  - Auto Delete Expired Account" | tee -a log-install.txt
echo "  - Full Orders For Various Services" | tee -a log-install.txt
echo "  - White Label" | tee -a log-install.txt
echo "  - Dev/Main          : MakhlukVpn"  | tee -a log-install.txt
echo "  - Telegram          : t.me/MakhlukVpn"  | tee -a log-install.txt
echo " " | tee -a log-install.txt
echo " {Script Auto Install By MakhlukVpn} " | tee -a log-install.txt | lolcat
echo " " | tee -a log-install.txt
echo "=======================================" | lolcat
# hapus sc dan pindahkan
cd /root
mv log-install.txt /root/.s/
mv domain /root/.s/
rm -f /root/nscf.sh
rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/openvpn.sh
rm -f /root/ssh-ws.sh
rm -f /root/ohp.sh
rm -f /root/setup.sh
echo -e "[ ${green}INFO${NC} ] Starting Reboot Vps"
sleep 1
echo " Reboot 10 Sec"
sleep 10
reboot
