#!/bin/bash
MYIP=$(wget -qO- icanhazip.com);
clear
echo -e "===============================" | lolcat
read -p "   Username : " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "   Day Extend : " Days
echo -e "===============================" | lolcat
Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User
egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "===============================" | lolcat
echo -e ""
echo -e "   Username    :  $User"
echo -e "   Days Added  :  $Days Days"
echo -e "   Expires on  :  $Expiration_Display"
echo -e ""
echo -e "===============================" | lolcat
echo -e "     Script By MakhlukVpn    "
echo -e "===============================" | lolcat
exho -e ""
else
clear
echo -e ""
echo -e "===============================" | lolcat
echo -e ""
echo -e "    Username Doesnt Exist        "
echo -e ""
echo -e "===============================" | lolcat
echo -e "    Script By MakhlukVpn          "
echo -e "===============================" | lolcat
echo -e ""
fi
sleep 2
menu
