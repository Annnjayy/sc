#!/bin/bash
# Script Credit by MakhlukVpn
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
blue='\033[0;34m'
ungu='\033[0;35m'
Green="\033[32m"
Red="\033[31m"
WhiteB="\e[0;37m"
BlueCyan="\e[0;36m"
Green_background="\033[42;37m"
Red_background="\033[41;37m"
Suffix="\033[0m"
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
#menu
function lane() {
    echo -e "===============================" | lolcat
}

function LOGO() {
    echo -e ""
    echo -e "===============================" | lolcat
    echo -e "       ⇱ Menu Slowdns ⇲"
    echo -e "===============================" | lolcat
	echo -e ""
}

function Credit_MakhlukVpn() {
    sleep 1
    echo -e "===============================" | lolcat
    echo -e ""
    echo -e "      Terimakasih Telah "
    echo -e "   Menggunakan Layanan Kami "
    echo -e ""
    echo -e "===============================" | lolcat
    echo -e ""
    exit 0
}

function add_iptables_ssh() {
  iptables -I INPUT -p udp --dport 5300 -j ACCEPT
  iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
  drop_host=143
  key=$(cat /etc/slowdns/server.key)
  pub=$(cat /etc/slowdns/server.pub)
  ns=$(cat /etc/xray/dns)
  sed -i "$ i\dnstt-server -udp :5300 -privkey ${key} ${ns} 127.0.0.1:${drop_host} > /dev/null &" /etc/rc.local
  systemctl restart rc-local
  iptables-save > /etc/iptables/rules.v4
  iptables-save > /etc/iptables.up.rules
  netfilter-persistent save
  netfilter-persistent reload
}

function del_iptables_ssh() {
  iptables -D INPUT -p udp --dport 5300 -j ACCEPT
  iptables -t nat -D PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
  PID_Screen=$(screen -ls | grep -w "slowdns" | awk '{print $1}' | cut -d. -f1)
  screen -X -S ${PID_Screen} quit
  key=$(cat /etc/slowdns/server.key)
  pub=$(cat /etc/slowdns/server.pub)
  ns=$(cat /etc/xray/dns)
  sed -i "/\bdnstt-server\b/d" /etc/rc.local
  sed -i '/^$/d' /etc/rc.local
  systemctl restart rc-local
  iptables-save > /etc/iptables/rules.v4
  iptables-save > /etc/iptables.up.rules
  netfilter-persistent save
  netfilter-persistent reload
}

function add_nameserver() {
  del_iptables_ssh
  clear
  lane
  rm /etc/xray/dns
  read -rp " Your Nameserver : " -e Nameserver
  echo -e ""
  echo "${Nameserver}" > /etc/xray/dns
  start_dns_ssh
}

function add_cert(){
    domain=$(cat /etc/xray/domain)
    echo -e "[ ${green}INFO${NC} ] Starting Install Cert..... " 
    sleep 0.5
    systemctl enable xray@v2ray-tls
    systemctl enable xray@v2ray-nontls
    systemctl enable xray@vless-tls
    systemctl enable xray@vless-nontls
    systemctl enable xray@trojan
    systemctl stop nginx
    echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
    sleep 2
    /root/.acme.sh/acme.sh --upgrade --auto-upgrade
    /root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
    /root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
    ~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /usr/local/etc/xray/xray.crt --keypath /usr/local/etc/xray/xray.key --ecc
    systemctl restart xray@v2ray-tls
    systemctl restart xray@v2ray-nontls
    systemctl restart xray@vless-tls
    systemctl restart xray@vless-nontls
    systemctl restart xray@trojan
    systemctl restart nginx
    echo -e "[ ${green}INFO${NC} ] All finished... " 
    sleep 0.5
}
function make_follow() {
    rm /etc/openvpn/tcp.ovpn
    rm /etc/openvpn/udp.ovpn
    rm /etc/openvpn/ssl.ovpn
    rm /home/vps/public_html/tcp.ovpn
    rm /home/vps/public_html/udp.ovpn
    rm /home/vps/public_html/ssl.ovpn
    MYIP=$(cat /etc/xray/domain)
    echo 1 > /proc/sys/net/ipv4/ip_forward
    sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
cat > /etc/openvpn/tcp.ovpn <<-END
client
dev tun
proto tcp
remote $MYIP 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
sed -i $MYIP /etc/openvpn/tcp.ovpn;
cat > /etc/openvpn/udp.ovpn <<-END
client
dev tun
proto udp
remote $MYIP 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
sed -i $MYIP /etc/openvpn/udp.ovpn;
cat > /etc/openvpn/ssl.ovpn <<-END
client
dev tun
proto tcp
remote $MYIP 990
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END
    sed -i $MYIP /etc/openvpn/ssl.ovpn;
}
function cert_ovpn() {
    echo '<ca>' >> /etc/openvpn/tcp.ovpn
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/tcp.ovpn
    echo '</ca>' >> /etc/openvpn/tcp.ovpn
    cp /etc/openvpn/tcp.ovpn /home/vps/public_html/tcp.ovpn
    
    echo '<ca>' >> /etc/openvpn/udp.ovpn   
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/udp.ovpn
    echo '</ca>' >> /etc/openvpn/udp.ovpn
    cp /etc/openvpn/udp.ovpn /home/vps/public_html/udp.ovpn
    
    echo '<ca>' >> /etc/openvpn/ssl.ovpn
    cat /etc/openvpn/server/ca.crt >> /etc/openvpn/ssl.ovpn
    echo '</ca>' >> /etc/openvpn/ssl.ovpn
    cp /etc/openvpn/ssl.ovpn /home/vps/public_html/ssl.ovpn
    cd /home/vps/public_html/
    zip OpenVPN.zip tcp.ovpn udp.ovpn ssl.ovpn
    cd
}

function add_host(){
    lane
    read -rp "Domain/Host : " -e domain
    echo "IP=$domain" >>/var/lib/crot/ipvps.conf
    rm -rf /etc/xray/domain
    echo $domain > /etc/xray/domain
    add_cert
    make_follow
    cert_ovpn
}

function start_dns_ssh() {
  del_iptables_ssh
  add_iptables_ssh
  stat_net=$(netstat -tunlp | grep dnstt-server)
  if [[ "${stat_net}" != "" ]]; then
    Nameserver=$(cat /etc/xray/dns)
    pub_key=$(cat /etc/slowdns/server.pub)
    clear
    LOGO
    echo -e " ${Green}SlowDNS is enabled${Suffix}"
    echo -e ""
    echo -e " Nameserver : ${yellow}${Nameserver}${Suffix}"
    echo -e " PUB Key    : ${blue}${pub_key}${Suffix}"
    Credit_MakhlukVpn
  else
    LOGO
    echo -e " ${Red}Failed to enable SlowDNS${Suffix}"
    Credit_MakhlukVpn
  fi
}

function stop_dns_ssh() {
  del_iptables_ssh
  LOGO
  echo -e " ${Green}SlowDNS is disabled${Suffix}"
  Credit_MakhlukVpn
}

function menu_dns() {
    echo -e ""
	echo -e "===============================" | lolcat
    echo -e "   ⇱ Menu Cloudflare Domain ⇲"
    echo -e "===============================" | lolcat
	echo -e ""
    echo -e "   1.)  Add Domain Manual"
    echo -e "   2.)  Add NS Domain Manual"
    LOGO
    echo -e "   3.)  Start SlowDNS SSH"
    echo -e "   4.)  Stop SlowDNS SSH"
    echo -e "   x.)  Back to Menu"
    echo -e ""
    lane
    read -p " Select from options [1-4 or x] : " port
    lane
    case ${port} in
    1)
    add_host
    menu_dns
    ;;
    2)
    add_nameserver
    menu_dns
    ;;
    3)
    start_dns_ssh
    ;;
    4)
    stop_dns_ssh
    ;;
    x)
    menu
    ;;
    *)
    echo -e " ${Red}Please enter an correct number${Suffix}"
    Credit_MakhlukVpn
    ;;
    esac
}

menu_dns
