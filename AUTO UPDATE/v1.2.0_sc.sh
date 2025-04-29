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
# requirements 
wget --no-check-certificate -q https://raw.githubusercontent.com/scriptvpskita/okdeinekejsksidjndv1/main/requirement.sh && chmod +x requirement.sh && ./requirement.sh && rm -rf requirement.sh
sleep 2
# delete limit ip & quota ssh
systemctl stop usage-ssh
systemctl stop limit-ssh
systemctl disable usage-ssh
systemctl disable limit-ssh
rm -rf /etc/systemd/system/usage-ssh.service
rm -rf /etc/systemd/system/limit-ssh.service
rm -rf /etc/xray/usage.ssh
rm -rf /etc/xray/limit.ssh
# noobzvpns
git clone https://github.com/willstore69/noobzvpns.git && noobzvpns/install.sh
rm -rf /root/noobzvpns
systemctl start noobzvpns
clear
# sslh
source /etc/os-release
release=$ID
os_version=$(cat /etc/os-release | grep -w "VERSION_ID" | awk -F'"' '{print $2}' | cut -d. -f1)

cat > /etc/default/sslh << END
# Default options for sslh initscript
# sourced by /etc/init.d/sslh

# binary to use: forked (sslh) or single-thread (sslh-select) version
# systemd users: don't forget to modify /lib/systemd/system/sslh.service
DAEMON=/usr/sbin/sslh

DAEMON_OPTS="--user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --tls 127.0.0.1:1369 --openvpn 127.0.0.1:1194 --http 127.0.0.1:1891 --anyprot 127.0.0.1:109 --pidfile /var/run/sslh/sslh.pid"
END

if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -ge 22 ]]; then

cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --tls 127.0.0.1:1369 --openvpn 127.0.0.1:1194 --http 127.0.0.1:1891 --anyprot 127.0.0.1:109 --pidfile /var/run/sslh/sslh.pid
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

else

cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground \$DAEMON_OPTS
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

fi
fi

if [[ "${release}" == "debian" ]]; then
if [[ "$os_version" -ge 11 ]]; then

cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --tls 127.0.0.1:1369 --openvpn 127.0.0.1:1194 --http 127.0.0.1:1891 --anyprot 127.0.0.1:109 --pidfile /var/run/sslh/sslh.pid
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

else

cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground \$DAEMON_OPTS
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

fi
fi

systemctl daemon-reload
systemctl enable sslh
systemctl start sslh
systemctl restart sslh
# nginx
awk '
/location \/ {/ {in_block=1}
in_block && /}/ {
    print;
    print "\n    location /noobzvpn {\n        proxy_pass http://127.0.0.1:2099;\n        proxy_http_version 1.1;\n        proxy_set_header Upgrade $http_upgrade;\n        proxy_set_header Connection \"Upgrade\";\n        proxy_set_header Host $host;\n        proxy_set_header X-Real-IP $remote_addr;\n        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;\n        real_ip_header X-Forwarded-For;\n    }";
    in_block=0;
    next
}
{print}
' /etc/nginx/conf.d/vmnone.conf > /etc/nginx/conf.d/vmnone.conf.tmp && mv /etc/nginx/conf.d/vmnone.conf.tmp /etc/nginx/conf.d/vmnone.conf
# xray dkk
mkdir -p /root/backup/
cp /usr/local/etc/xray/config.json /root/backup/
cp /usr/local/etc/xray/none.json /root/backup/
cp /usr/local/etc/xray/will666.json /root/backup/
cp /usr/local/etc/xray/will69.json /root/backup/

# DATA SERVER
cek_trojanws_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "TrojanWS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmesstcp_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "Vmess-TCP " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmessws_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VmessWS-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessws_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VlessWS-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmessupgrade_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VmessUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessupgrade_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VlessUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_trojanupgrade_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "TrojanUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_trojangrpc_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "TrojanGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessgrpc_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VlessGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmessgrpc_tls=$(cat /usr/local/etc/xray/config.json | grep -w -A 1 "VmessGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmessws_ntls=$(cat /usr/local/etc/xray/none.json | grep -w -A 1 "VmessWS-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessws_ntls=$(cat /usr/local/etc/xray/none.json | grep -w -A 1 "VlessWS-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vmessupgrade_ntls=$(cat /usr/local/etc/xray/none.json | grep -w -A 1 "VmessUPGRADE-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessupgrade_ntls=$(cat /usr/local/etc/xray/none.json | grep -w -A 1 "VlessUPGRADE-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_vlessxtls=$(cat /usr/local/etc/xray/will666.json | grep -w -A 1 "VlessXTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')
cek_trojantcp=$(cat /usr/local/etc/xray/will69.json | grep -w -A 1 "Trojan " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d')

# DATA BACKUP
cat /root/backup/config.json | grep -w -A 1 "TrojanWS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/trojanws_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "Vmess-TCP " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmesstcp_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VmessWS-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmessws_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VlessWS-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessws_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VmessUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmessupgrade_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VlessUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessupgrade_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "TrojanUPGRADE-TLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/trojanupgrade_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "TrojanGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/trojangrpc_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VlessGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessgrpc_tls_data.json 2>/dev/null
cat /root/backup/config.json | grep -w -A 1 "VmessGRPC " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmessgrpc_tls_data.json 2>/dev/null
cat /root/backup/none.json | grep -w -A 1 "VmessWS-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmessws_ntls_data.json 2>/dev/null
cat /root/backup/none.json | grep -w -A 1 "VlessWS-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessws_ntls_data.json 2>/dev/null
cat /root/backup/none.json | grep -w -A 1 "VmessUPGRADE-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vmessupgrade_ntls_data.json 2>/dev/null
cat /root/backup/none.json | grep -w -A 1 "VlessUPGRADE-NTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessupgrade_ntls_data.json 2>/dev/null
cat /root/backup/will666.json | grep -w -A 1 "VlessXTLS " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/vlessxtls_data.json 2>/dev/null
cat /root/backup/will69.json | grep -w -A 1 "Trojan " | awk -v user="### $nameofuser" ' /^--$/ {if (block ~ user) {print block;exit}block = ""}{ block = block $0 ORS }END { if (block ~ user) print block }' | sed '$d' > /tmp/trojan_tcp_data.json 2>/dev/null

# GABUNGKAN SERVER & BACKUP
cat $cek_trojanws_tls /tmp/trojanws_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_trojanws_tls_data.json 2>/dev/null
cat $cek_vmesstcp_tls /tmp/vmesstcp_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmesstcp_tls_data.json 2>/dev/null
cat $cek_vmessws_tls /tmp/vmessws_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmessws_tls_data.json 2>/dev/null
cat $cek_vlessws_tls /tmp/vlessws_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessws_tls_data.json 2>/dev/null
cat $cek_vmessupgrade_tls /tmp/vmessupgrade_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmessupgrade_tls_data.json 2>/dev/null
cat $cek_vlessupgrade_tls /tmp/vlessupgrade_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessupgrade_tls_data.json 2>/dev/null
cat $cek_trojanupgrade_tls /tmp/trojanupgrade_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_trojanupgrade_tls_data.json 2>/dev/null
cat $cek_trojangrpc_tls /tmp/trojangrpc_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_trojangrpc_tls_data.json 2>/dev/null
cat $cek_vlessgrpc_tls /tmp/vlessgrpc_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessgrpc_tls_data.json 2>/dev/null
cat $cek_vmessgrpc_tls /tmp/vmessgrpc_tls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmessgrpc_tls_data.json 2>/dev/null
cat $cek_vmessws_ntls /tmp/vmessws_ntls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmessws_ntls_data.json 2>/dev/null
cat $cek_vlessws_ntls /tmp/vlessws_ntls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessws_ntls_data.json 2>/dev/null
cat $cek_vmessupgrade_ntls /tmp/vmessupgrade_ntls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vmessupgrade_ntls_data.json 2>/dev/null
cat $cek_vlessupgrade_ntls /tmp/vlessupgrade_ntls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessupgrade_ntls_data.json 2>/dev/null
cat $cek_vlessxtls /tmp/vlessxtls_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_vlessxtls_data.json 2>/dev/null
cat $cek_trojantcp /tmp/trojan_tcp_data.json 2>/dev/null | awk '!seen[$0]++' > /tmp/hasil_trojan_tcp_data.json 2>/dev/null
#pisahin
cp /usr/local/etc/xray/config.json /tmp/backup_config.json
cp /usr/local/etc/xray/will666.json /tmp/backup_will666.json
cp /usr/local/etc/xray/will666.json /tmp/backup_will69.json
cp /usr/local/etc/xray/none.json /tmp/backup_none.json
rm -rf /usr/local/etc/xray/config.json
rm -rf /usr/local/etc/xray/will666.json
rm -rf /usr/local/etc/xray/none.json
#
wget -q https://raw.githubusercontent.com/scriptvpskita/x/refs/heads/main/crot/crot/crot/crot/crot/crot/crott.sh && chmod +x crott.sh && ./crott.sh
#
sed -i "/^#trojanws$/ r /tmp/hasil_trojanws_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vmesstcp$/ r /tmp/hasil_vmesstcp_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vmessws$/ r /tmp/hasil_vmessws_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vlessws$/ r /tmp/hasil_vlessws_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vmessupgrade$/ r /tmp/hasil_vmessupgrade_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vlessupgrade$/ r /tmp/hasil_vlessupgrade_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#trojanupgrade$/ r /tmp/hasil_trojanupgrade_tls_data.json" /usr/local/etc/xray/config.json
# grpc on config.json
sed -i "/^#trojanGRPCX$/ r /tmp/hasil_trojangrpc_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vmessGRPCX$/ r /tmp/hasil_vmessgrpc_tls_data.json" /usr/local/etc/xray/config.json
sed -i "/^#vlessGRPCX$/ r /tmp/hasil_vlessgrpc_tls_data.json" /usr/local/etc/xray/config.json
# tls on will666.json
sed -i "/^#vlessxtls$/ r /tmp/hasil_vlessxtls_data.json" /usr/local/etc/xray/will666.json
# tls on will69.json
sed -i "/^#trojantcp$/ r /tmp/hasil_trojantcp_data.json" /usr/local/etc/xray/will69.json
# ntls on none.json
sed -i "/^#vmessWS$/ r /tmp/hasil_vmessws_ntls_data.json" /usr/local/etc/xray/none.json
sed -i "/^#vlessWS$/ r /tmp/hasil_vlessws_ntls_data.json" /usr/local/etc/xray/none.json
sed -i "/^#vmessUPGRADE$/ r /tmp/hasil_vmessupgrade_ntls_data.json" /usr/local/etc/xray/none.json
sed -i "/^#vlessUPGRADE$/ r /tmp/hasil_vlessupgrade_ntls_data.json" /usr/local/etc/xray/none.json
#
systemctl restart xray
systemctl restart xray@none
systemctl restart will69
systemctl restart will666
#
wget -q -O /etc/william/PDirect.js https://raw.githubusercontent.com/xkjdox/sojsiws/refs/heads/main/ndjdjdjdi.js
wget --no-check-certificate -q -O /usr/bin/apxb "https://raw.githubusercontent.com/scriptvpskita/okdeinekejsksidjndv1/main/apxb"
wget --no-check-certificate -q -O /usr/bin/apxx "https://raw.githubusercontent.com/scriptvpskita/okdeinekejsksidjndv1/main/apxx"
chmod +x /usr/bin/apxb
chmod +x /usr/bin/apxx
systemctl restart apibot
systemctl restart apisc
systemctl restart cdn
systemctl enable dropbear
#
rm -rf .bash_history
echo "1.2.0" > /home/ver