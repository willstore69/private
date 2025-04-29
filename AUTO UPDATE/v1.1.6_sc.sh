#!/usr/bin/env bash
if [[ $(ulimit -c) != "0" ]]; then
  echo "Im Watching You..."
  echo "- @user_legend"
  exit 1
fi

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
IP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') ipinfo.io/ip > /tmp/ipaddress.txt)
MYIP=$(cat /tmp/ipaddress.txt)
if [ -z "$MYIP" ]; then
IP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') http://ip-api.com/json | jq .query | tr -d '"' > /tmp/ipaddress.txt)
MYIP=$(cat /tmp/ipaddress.txt)
fi
if [ -z "$MYIP" ]; then
IP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') ipinfo.io | jq .ip | tr -d '"' > /tmp/ipaddress.txt)
MYIP=$(cat /tmp/ipaddress.txt)
fi

# cek wget & curl
if ! which wget > /dev/null; then
clear
echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
sleep 2
exit 0
clear
else
echo "Wget is already installed"
fi

if ! which curl > /dev/null; then
clear
echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
sleep 2
exit 0
clear
else
echo "curl is already installed"
fi

fileee=/usr/bin/wget
minimumsize=400000
actualsize=$(wc -c <"$fileee")
if [ $actualsize -ge $minimumsize ]; then
clear
echo -e "${green}Checking...${NC}"
else
clear
echo -e "${red}Permission Denied!${NC}";
echo "Reason : Modified Package To Bypass Sc"
exit 0
fi

fileeex=/usr/bin/curl
minimumsizex=15000
clear
actualsizex=$(wc -c <"$fileeex")
if [ $actualsizex -ge $minimumsizex ]; then
clear
echo -e "${green}Checking...${NC}"
else
clear
echo -e "${red}Permission Denied!${NC}";
echo "Reason : Modified Package To Bypass Sc"
exit 0
fi

# data server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

repogithub='scriptvpskita/okdeinekejsksidjndv1/main'
repopermission='https://regist.scxwill.web.id/scvps/permission.txt'
curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission | grep -w "$MYIP" > /tmp/logs.txt
if [ $? -ne 0 ]; then
  repopermission='https://regist.myenemyisyours.my.id/scvps/permission.txt'
  curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission | grep -w "$MYIP" > /tmp/logs.txt
  if [ $? -ne 0 ]; then
    repopermission='http://yourenemy.scwill.my.id:8081/permission.txt'
    curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission | grep -w "$MYIP" > /tmp/logs.txt
    if [ $? -ne 0 ]; then
      echo -e "${red}There's a Problem With Your Connection ❗${NC}"
      exit 1
    fi
  fi
fi

# cek masa aktif
data=( `cat /tmp/logs.txt | grep -E "^### " | awk '{print $2}'` )
for user in "${data[@]}"
do
exp=( `grep -E "^### $data" "/tmp/logs.txt" | awk '{print $3}' | sort | uniq` )
d1=(`date -d "$exp" +%s`)
d2=(`date -d "$biji" +%s`)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
echo -e "${red}Script Expired !${NC}"
echo -e "Contact Admin : t.me/user_legend"
rm -rf /tmp/logs.txt
rm -rf /tmp/ipaddress.txt
exit 1
else
echo -e "${green}Script Active !${NC}"
clear
fi
done

# cek ip address
checkipaddres=( `grep -E "^### $data" "/tmp/logs.txt" | awk '{print $4}' | sort | uniq` )
if [[ "$MYIP" = "$checkipaddres" ]]; then
echo -e "${green}IP Address Accepted${NC}"
clear
else
echo -e "${red}IP Address Not Found In Our Database${NC}"
echo -e "Contact Admin : t.me/user_legend"
rm -rf /tmp/logs.txt
rm -rf /tmp/ipaddress.txt
exit 1
fi

# cek client name
clientname=$(cat /usr/local/etc/clientname)
checkclient=( `grep -E "^### $data" "/tmp/logs.txt" | awk '{print $2}' | sort | uniq` )
if [[ "$clientname" = "$checkclient" ]]; then
echo -e "${green}Client Name Accepted${NC}"
clear
else
echo -e "${red}Client Name Not Compatible !${NC}"
echo -e "Contact Admin : t.me/user_legend"
rm -rf /tmp/logs.txt
rm -rf /tmp/ipaddress.txt
exit 1
fi
rm -rf /tmp/logs.txt
rm -rf /tmp/ipaddress.txt
clear

echo "Starting Update...."
#
wget --no-check-certificate https://raw.githubusercontent.com/$repogithub/requirement.sh && chmod +x requirement.sh && ./requirement.sh && rm -rf requirement.sh
sleep 2
#
rm -rf /root/.config/rclone/rclone.conf
wget --no-check-certificate -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/scriptvpskita/desktop/main/src/browser/app/xcxvs"
chmod +x /root/.config/rclone/rclone.conf
sleep 1
#
sleep 1
domain=$(cat /etc/xray/domain)
cat > /etc/nginx/conf.d/vmnone.conf << END
server {
        if (\$http_user_agent ~* "CheckHost") {
            return 403;
        }
        if (\$http_user_agent ~* "VirusTotal") {
            return 403;
        }
        if (\$http_user_agent ~* "CensysInspect") {
            return 403;
        }
        if (\$http_user_agent ~* "Shodan") {
            return 403;
        }
        if (\$http_user_agent ~* "SecurityTrails") {
            return 403;
        }
    listen 127.0.0.1:21408 backlog=65535 reuseport default_server;
    listen 80 backlog=65535 reuseport default_server;
    listen 8080 backlog=65535 reuseport default_server;
    listen 2082 backlog=65535 reuseport default_server;
    listen 2086 backlog=65535 reuseport default_server;
    listen 69 backlog=65535 reuseport default_server;
    listen 55 backlog=65535 reuseport default_server;
    server_name _;

    location ^~ /user_legend/ {
        proxy_pass http://127.0.0.1:5069;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }

    location ~* ^/(a|b|c|d|e|f|g|h|i|j|k|l|m|n|p|q|r|sa|t|u|vmessws|w|x|y|z) {
        if (\$http_connection = 'Upgrade') {
            rewrite /(.*) /vmessws break;
            proxy_pass http://127.0.0.1:5210;
        }
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        real_ip_header X-Forwarded-For;
    }

    location /vmessupgrade {
        proxy_pass http://127.0.0.1:5212;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        real_ip_header X-Forwarded-For;
    }

    location /vlessupgrade {
        proxy_pass http://127.0.0.1:5213;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        real_ip_header X-Forwarded-For;
    }

    location / {
        proxy_pass http://127.0.0.1:2052;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        real_ip_header X-Forwarded-For;
    }

    location /ovpn {
        proxy_pass http://127.0.0.1:2095;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        real_ip_header X-Forwarded-For;
    }
}
END

systemctl restart nginx
#
pip3 install uvicorn==0.34.0 > /dev/null 2>&1
pip3 install fastapi==0.115.8 > /dev/null 2>&1
sleep 1
rm -rf /usr/bin/apxx
wget --no-check-certificate -q -O /usr/bin/apxx "https://raw.githubusercontent.com/$repogithub/apxx"
wget --no-check-certificate -q -O /usr/bin/apxb "https://raw.githubusercontent.com/$repogithub/apxb"
chmod +x /usr/bin/apxx
chmod +x /usr/bin/apxb

cat > /etc/systemd/system/apisc.service << END 
[Unit]
Description=oke gas
After=network.target

[Service]
ExecStart=/usr/bin/apxx
Restart=always
User=root
Group=root
Environment="PYTHONUNBUFFERED=1"

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable apisc
systemctl start apisc
systemctl restart apisc
sleep 1

cat > /etc/systemd/system/apibot.service << END
[Unit]
Description=Services API BOT TELEGRAM By @user_legend
After=network.target

[Service]
ExecStart=/usr/bin/apxb
Restart=always
RestartSec=3
User=root
Group=root
AmbientCapabilities=CAP_DAC_OVERRIDE
LimitNOFILE=infinity
OOMScoreAdjust=100

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable apibot.service > /dev/null 2>&1 2>/dev/null
systemctl start apibot.service > /dev/null 2>&1 2>/dev/null
systemctl restart apibot.service > /dev/null 2>&1 2>/dev/null
sleep 2
#
wget --no-check-certificate -q -O /usr/bin/del-expiee "https://raw.githubusercontent.com/$repogithub/del-expiee.sh"
chmod +x /usr/bin/del-expiee
cat > /etc/systemd/system/deleted-vpn.service << END 
[Unit]
Description=My Custom Service with Delay
After=network.target

[Service]
ExecStart=/usr/bin/del-expiee
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable deleted-vpn
systemctl start deleted-vpn
#
rm -rf .bash_history
echo "1.1.6" > /home/ver