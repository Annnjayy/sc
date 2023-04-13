# sc Testing🗿

 Disarankan kalau sudah install scriptnya
lihat dulu service runningnya di menu info script,
lihat ada yang error gak, kalau ada yang error
restart service dan Renew Certificate xray

 Dan jikalau slowdns nya ga berfungsi
maka pilih start slowdns di menu domain.

</h2>
<h2 align="center">Protokol Tunneling SSH</h2>

[![Hits](https://img.shields.io/badge/SSH_OpenSSH-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_Dropber-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_SSLH-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_Stunnel5-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_Squid-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_OHP-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_Websocket-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_OpenVPN-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/SSH_SlowDNS-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/XRAY_VLESS-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/XRAY_VMESS-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
[![Hits](https://img.shields.io/badge/XRAY_TROJAN-F38020?style=for-the-badge&logo=Cloudflare&logoColor=white&edge_flat=false)](https://github.com/Annnjayy/sc)
# Update System
````
apt update -y && apt upgrade -y && update-grub && sleep 2 && reboot
````
# Install Script
````
apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/Annnjayy/sc/main/setup.sh && bash setup.sh
````
# Os Supported

• Debian 10 & 9

• Ubuntu 18.04 & 20.04

# Service & Port

 OpenSSH                   : 22, 2253

 Dropbear                  : 443, 109, 143, 1153

 Stunnel5                  : 443, 445, 777

 OpenVPN                   : TCP 1194, UDP 2200, SSL 990

 SSH TLS                   : 443, 445, 777

 SSH WS TLS                : 443 [MAINTENANCE]

 SSH WS NTLS               : 8880

 WS OpenVPN                : 2086

 Squid Proxy               : 3128, 8080

 Badvpn                    : 7100, 7200, 7300

 Nginx                     : 89

 XRAYS Vmess TLS           : 8443

 XRAYS Vmess NTLS          : 80

 XRAYS Vless TLS           : 2083

 XRAYS Vless NTLS          : 2095

 XRAYS Trojan              : 2087

 Trojan Go                 : 2053

 OHP SSH                   : 8181

 OHP Dropbear              : 8282

 OHP OpenVPN               : 8383

 SlowDNS                   : [ON]

 ### Server Information & Other Features

• Timezone                : Asia/Jakarta (GMT +7)

• Fail2Ban                : [ON]

• Dflate                  : [ON]

• IPtables                : [ON]

• Auto-Reboot             : [ON]

• IPv6                    : [OFF]
