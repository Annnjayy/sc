#!/bin/bash
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi
echo -e "[ ${green}INFO${NC} ] Starting Update Package " 
sleep 2
#update
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt -y install wget curl
apt install lolcat -y
# Install Requirements Tools
apt install ruby -y
apt install python -y
apt install make -y
apt install cmake -y
apt install coreutils -y
apt install rsyslog -y
apt install net-tools -y
apt install zip -y
apt install unzip -y
apt install nano -y
apt install sed -y
apt install gnupg -y
apt install gnupg1 -y
apt install bc -y
apt install jq -y
apt install apt-transport-https -y
apt install build-essential -y
apt install dirmngr -y
apt install libxml-parser-perl -y
apt install neofetch -y
apt install git -y
apt install lsof -y
apt install libsqlite3-dev -y
apt install libz-dev -y
apt install gcc -y
apt install g++ -y
apt install libreadline-dev -y
apt install zlib1g-dev -y
apt install libssl-dev -y
apt install libssl1.0-dev -y
apt install dos2unix -y
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
# info script install
if [ -f "/etc/xray/domain" ]; then
echo -e "===============================" | lolcat
echo -e "   Script Already Installed"
echo -e "===============================" | lolcat
exit 0
fi
# Nama pengguna
mkdir .s
echo -e "===============================" | lolcat
read -rp " Nama/Pengguna : " -e nama
echo -e "===============================" | lolcat
echo $nama > /root/.s/pengguna
mkdir /var/lib/crot;
echo "IP=" >> /var/lib/crot/ipvps.conf
# install cloudflare certificate
echo -e "[ ${green}INFO${NC} ] Starting Getting Cert... "
sleep 2
wget https://${service}/cf.sh
bash cf.sh
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
#install xray certificate cloudflare
echo -e "[ ${green}INFO${NC} ] Starting Install Cert "
sleep 2
wget https://${menu}/certv2ray.sh
bash certv2ray.sh
# install slowdns cloudflare certificate
wget https://${instal}/nscf.sh
bash nscf.sh

#delete sc yabg sudah terinstall
rm -f /root/ssh-vpn.sh
rm -f /root/ins-xray.sh
rm -f /root/ipsaya.sh
rm -f /root/openvpn.sh
rm -f /root/ssh-ws.sh
rm -f /root/ohp.sh
rm -f /root/nscf.sh
rm -f /root/tool.sh
rm -f /root/certv2ray.sh
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
echo " "
echo "================= {Service & Port} ==================" | tee -a log-install.txt | lolcat
echo ""
echo "   - OpenSSH                   : 22, 2253"  | tee -a log-install.txt
echo "   - OpenVPN                   : TCP 1194, UDP 2200, SSL 990, 443"  | tee -a log-install.txt
echo "   - Stunnel5                    : 443, 445"  | tee -a log-install.txt
echo "   - Dropbear                   : 443, 109, 143"  | tee -a log-install.txt
echo "   - Squid Proxy                 : 3128, 8080"  | tee -a log-install.txt
echo "   - Badvpn                      : 7100, 7200, 7300"  | tee -a log-install.txt
echo "   - Nginx                       : 89"  | tee -a log-install.txt
echo "   - XRAYS Vmess TLS          : 443"  | tee -a log-install.txt
echo "   - XRAYS Vmess None TLS    : 80"  | tee -a log-install.txt
echo "   - XRAYS Vless TLS           : 443"  | tee -a log-install.txt
echo "   - XRAYS Vless None TLS     : 80"  | tee -a log-install.txt
echo "   - XRAYS Trojan WS          : 2053"  | tee -a log-install.txt
echo "   - XRAYS Trojan GO           : 2087"  | tee -a log-install.txt
echo "   - Websocket TLS             : 443, "  | tee -a log-install.txt
echo "   - Websocket None TLS       : 80, "  | tee -a log-install.txt
echo "   - Websocket Ovpn            : 2086"  | tee -a log-install.txt
echo "   - OHP SSH                   : 8181"  | tee -a log-install.txt
echo "   - OHP Dropbear              : 8282"  | tee -a log-install.txt
echo "   - OHP OpenVPN              : 8383"  | tee -a log-install.txt
echo "   - SLOWDNS UDP             : 53, 5300 "  | tee -a log-install.txt
echo "   - SLOWDNS SSL/TLS         : 443 "  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo ""
echo "=========== {Server Information & Other Features} =========="  | tee -a log-install.txt | lolcat
echo ""
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                 : [ON]"  | tee -a log-install.txt
echo "   - Dflate                   : [ON]"  | tee -a log-install.txt
echo "   - IPtables                 : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On 05.00 GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo "   - White Label" | tee -a log-install.txt
echo "   - Installation Log --> /root/log-install.txt"  | tee -a log-install.txt
echo "   - Dev/Main                : MakhlukVpn"  | tee -a log-install.txt
echo "   - Telegram                 : t.me/MakhlukVpn"  | tee -a log-install.txt
echo ""
echo "============= {Script Created By MakhlukVpn} ============" | tee -a log-install.txt | lolcat
echo -e "[ ${green}INFO${NC} ] Starting Reboot Vps"
sleep 1
echo " Reboot 10 Sec"
sleep 10
rm -f setup.sh
reboot
