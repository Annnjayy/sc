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
# Proxy For Ssh & Ovpn Websocket
echo -e "===============================" | lolcat
echo -e " Installing SSH Websocket-OVPN "
echo -e "===============================" | lolcat
sleep 1
echo -e "[ ${green}INFO${NC} ] Starting Install Ssh....... " 
sleep 1
# Getting Proxy Template
wget --output-document=/usr/local/bin/ws-nontls https://raw.githubusercontent.com/Annnjayy/sc/main/install/ws-ntls.py
wget --output-document=/usr/local/bin/ws-tls https://raw.githubusercontent.com/Annnjayy/sc/main/install/ws-tls.py
wget --output-document=/usr/local/bin/ws-ovpn https://raw.githubusercontent.com/Annnjayy/sc/main/install/ws-ovpn.py
chmod +x /usr/local/bin/ws-nontls
chmod +x /usr/local/bin/ws-tls
chmod +x /usr/local/bin/ws-ovpn

# Installing Service ws nontls
cat > /etc/systemd/system/ws-nontls.service << END
[Unit]
Description=SSH Websocket By MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-nontls 8880
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-nontls
systemctl restart ws-nontls

# Installing Service ws tls
cat > /etc/systemd/system/ws-tls.service << END
[Unit]
Description=SSH Websocket By MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-tls 443
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-tls
systemctl restart ws-tls

# Installing Service
cat > /etc/systemd/system/ws-ovpn.service << END
[Unit]
Description=  Websocket OpenVPN By MakhlukVpn
Documentation=https://t.me/MakhlukVpn
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python -O /usr/local/bin/ws-ovpn 2086
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ws-ovpn
systemctl restart ws-ovpn

echo -e "===============================" | lolcat
echo -e "  Done Install SSH & Ovpn WS "
echo -e "===============================" | lolcat
echo -e "  PORT SSH NONTLS : 8880        "
echo -e "  PORT SSH TLS    : 443        "
echo -e "  PORT OVPN WS    : 2086      "
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn    "
echo -e "===============================" | lolcat
#hapus sc
rm /root/ssh-ws.sh
sleep 2
