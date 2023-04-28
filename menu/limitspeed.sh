#!/bin/bash

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/limit)
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
function start () {
echo -e "Limit Speed All Service"
read -p "Set maximum download rate (in Kbps): " down
read -p "Set maximum upload rate (in Kbps): " up
if [[ -z "$down" ]] && [[ -z "$up" ]]; then
echo > /dev/null 2>&1
else
echo "Start Configuration"
sleep 0.5
wondershaper -a $IFACE -d $down -u $up > /dev/null 2>&1
cat > /etc/systemd/wondershaper.conf << END
[wondershaper]

# Adapter
IFACE="$IFACE"

# Download rate in Kbps
DSPEED="$down"

# Upload rate in Kbps
USPEED="$up"

### Separate items by whitespace:
 
#HIPRIODST=(IP1 IP2)
HIPRIODST=()
 
COMMONOPTIONS=()
 
# low priority OUTGOING traffic - you can leave this blank if you want
# low priority source netmasks
NOPRIOHOSTSRC=(80);
 
# low priority destination netmasks
NOPRIOHOSTDST=();
 
# low priority source ports
NOPRIOPORTSRC=();
 
# low priority destination ports
NOPRIOPORTDST=();
 
### EOF
END
cat > /etc/systemd/system/wondershaper.service << END
[Unit]
Description=Bandwidth-Limit
Documentation=https://t.me/MakhlukVpn
After=syslog.target network-online.target
[Service]
User=root
NoNewPrivileges=true
ExecStart=/usr/local/sbin/wondershaper -a $IFACE -d $down -u $up
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000
[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable --now wondershaper.service
sleep 0.5
echo "start" > /home/limit
echo "Done"

read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
fi
}
function stop () {
wondershaper -ca $NIC
systemctl stop wondershaper.service
echo "Stop Configuration"
sleep 0.5
echo > /home/limit
echo "Done"
read -n 1 -s -r -p "Press [ Enter ] to back on menu"
menu
}
if [[ "$cek" = "start" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "===============================" | lolcat
echo -e "    Limit Bandwidth Speed $sts    "
echo -e "===============================" | lolcat
echo -e " 1}.$green Start Limit"
echo -e " 2}.$green Stop Limit"
echo -e " 3}.$green Back To Menu"
echo -e " x}.$red Exit"
echo -e "===============================" | lolcat
read -rp "Please Input Number [1-3 or [x] ] : " -e num
echo -e "===============================" | lolcat
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
elif [[ "$num" = "3" ]]; then
menu
elif [[ "$num" = "x" ]]; then
exit
else
clear
echo " You Entered The Wrong Number"
menu
fi
