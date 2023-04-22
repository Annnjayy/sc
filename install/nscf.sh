#!/bin/sh
clear
#color
red='\e[1;31m'
green='\033[0;32m'
NC='\e[0m'
yellow='\033[0;33m'
Suffix="\033[0m"
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Loading....."
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
#info
REPO="https://raw.githubusercontent.com/Annnjayy/sc/main/service/"
echo "=====================================" | lolcat
echo " Installing Cert Cloudflare NSDomain        "
echo "=====================================" | lolcat
sleep 1
echo -e "[ ${green}INFO${NC} ] Starting Install NS Cert.... " 
sleep 1
ns_domain_cloudflare() {
	DOMAIN="makhlukvpn.my.id"
	DOMAIN_PATH=$(cat /etc/xray/domain)
	NS_DOMAIN=ns-${DOMAIN}
	CF_ID=makhlukvpn@gmail.com
        CF_KEY=1e1fd5209818f9492309a6c60b94e1df4340f
	set -euo pipefail
	IP=$(wget -qO- ipinfo.io/ip)
	echo "Updating DNS NS for ${NS_DOMAIN}..."
	ZONE=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
		-H "X-Auth-Email: ${CF_ID}" \
		-H "X-Auth-Key: ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	RECORD=$(
		curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
		-H "X-Auth-Email: ${CF_ID}" \
		-H "X-Auth-Key: ${CF_KEY}" \
		-H "Content-Type: application/json" | jq -r .result[0].id
	)

	if [[ "${#RECORD}" -le 10 ]]; then
		RECORD=$(
			curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
			-H "X-Auth-Email: ${CF_ID}" \
			-H "X-Auth-Key: ${CF_KEY}" \
			-H "Content-Type: application/json" \
			--data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DOMAIN_PATH}'","proxied":false}' | jq -r .result.id
		)
	fi

	RESULT=$(
		curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
		-H "X-Auth-Email: ${CF_ID}" \
		-H "X-Auth-Key: ${CF_KEY}" \
		-H "Content-Type: application/json" \
		--data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${DOMAIN_PATH}'","proxied":false}'
	)
	echo $NS_DOMAIN >/etc/xray/dns
}

function gen_core_key() {
	mkdir -p /etc/slowdns
	wget --output-document=/usr/sbin/dnstt-server "${REPO}dnstt-server" >/dev/null 2>&1
	chmod +x /usr/sbin/dnstt-server >/dev/null 2>&1
	cd /usr/sbin
	./dnstt-server -gen-key -privkey-file /etc/slowdns/server.key -pubkey-file /etc/slowdns/server.pub
	cd /etc/slowdns
	chmod +x *
	cd
}

function input_nameserver() {
  _Active=$(systemctl is-active systemd-resolved)
  if [[ "${_Active}" == "inactive" ]]; then
    systemctl enable systemd-resolved > /dev/null 2>&1
    systemctl start systemd-resolved > /dev/null 2>&1
    cf=$(cat /etc/resolv.conf | grep -w "nameserver 1.1.1.1")
    gg=$(cat /etc/resolv.conf | grep -w "nameserver 8.8.8.8")
    gg1=$(cat /etc/resolv.conf | grep -w "nameserver 8.8.4.4")
    if [[ "${cf}" == "" ]]; then
    echo "nameserver 1.1.1.1" >> /etc/resolv.conf
    fi
    if [[ "${gg}" == "" ]]; then
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf
    fi
    if [[ "${gg1}" == "" ]]; then
    echo "nameserver 8.8.4.4" >> /etc/resolv.conf
    fi
    systemctl restart systemd-resolved > /dev/null 2>&1
  else
    cf=$(cat /etc/resolv.conf | grep -w "nameserver 1.1.1.1")
    gg=$(cat /etc/resolv.conf | grep -w "nameserver 8.8.8.8")
    gg1=$(cat /etc/resolv.conf | grep -w "nameserver 8.8.4.4")
    if [[ "${cf}" == "" ]]; then
    echo "nameserver 1.1.1.1" >> /etc/resolv.conf
    fi
    if [[ "${gg}" == "" ]]; then
    echo "nameserver 8.8.8.8" >> /etc/resolv.conf
    fi
    if [[ "${gg1}" == "" ]]; then
    echo "nameserver 8.8.4.4" >> /etc/resolv.conf
    fi
    systemctl restart systemd-resolved > /dev/null 2>&1
  fi
}

function add_iptables_ssh() {
  iptables -I INPUT -p udp --dport 5300 -j ACCEPT
  iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
  drop_host=143
  key=$(cat /etc/slowdns/server.key)
  ns=$(cat /etc/xray/dns)
  sed -i "$ i\dnstt-server -udp :5300 -privkey ${key} ${ns} 127.0.0.1:${drop_host} > /dev/null &" /etc/rc.local
  systemctl restart rc-local
  iptables-save >/etc/iptables/rules.v4 >/dev/null 2>&1
  iptables-save >/etc/iptables.up.rules >/dev/null 2>&1
  netfilter-persistent save
  netfilter-persistent reload
}

function start_dns_ssh() {
  add_iptables_ssh
  stat_net=$(netstat -tunlp | grep dnstt-server)
  if [[ "${stat_net}" != "" ]]; then
    Nameserver=$(cat /etc/xray/dns)
    pub_key=$(cat /etc/slowdns/server.pub)
    echo -e ""
    echo -e "===============================" | lolcat
    echo -e "    ⇱ Done Install Slowdns ⇲"
    echo -e "===============================" | lolcat
	echo -e ""
    echo -e " ${Green}SlowDNS is enabled${Suffix}"
    echo -e ""
    echo -e " Nameserver : ${yellow}${Nameserver}${Suffix}"
    echo -e " PUB Key    : ${pub_key}${Suffix}"
    sleep 2
  fi
}

function ns_domain() {
    ns_domain_cloudflare
    gen_core_key
    input_nameserver
    start_dns_ssh
}
ns_domain
#hapus sc
rm /root/nscf.sh
