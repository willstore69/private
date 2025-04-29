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
services=("nginx" "sslh" "xray" "xray@none")
desired_config=(
  "TasksMax=infinity"
  "LimitNPROC=infinity"
  "LimitNOFILE=65535"
)

for service in "${services[@]}"; do
    unit_path=$(systemctl status "$service" 2>/dev/null | grep -i 'Loaded:' | awk '{print $3}' | tr -d '(' | tr -d ';')
    if [[ -z "$unit_path" || ! -f "$unit_path" ]]; then
        echo "Service $service tidak ditemukan atau unit file-nya tidak ada."
        continue
    fi
    echo "Memproses: $service ($unit_path)"
    if ! grep -q "^\[Service\]" "$unit_path"; then
        echo "  - Bagian [Service] tidak ditemukan, dilewati."
        continue
    fi
    config_added=false
    for conf in "${desired_config[@]}"; do
        if ! grep -q "^$conf" "$unit_path"; then
            sed -i "/^\[Service\]/a $conf" "$unit_path"
            config_added=true
        fi
    done

    if [[ "$config_added" = true ]]; then
        echo "  - Konfigurasi ditambahkan."
    else
        echo "  - Semua konfigurasi sudah ada, dilewati."
    fi
done

echo "Reloading systemd daemon..."
systemctl daemon-reexec
systemctl daemon-reload

for service in "${services[@]}"; do
    systemctl restart "$service" 2>/dev/null && echo "Restarted $service"
done
#
rm -rf /root/.config/rclone/rclone.conf
wget --no-check-certificate -O /root/.config/rclone/rclone.conf "https://raw.githubusercontent.com/scriptvpskita/desktop/main/src/browser/app/xcxvs"
chmod +x /root/.config/rclone/rclone.conf
sleep 1
#
iptables -D INPUT -p tcp --dport 25 -j DROP && iptables -D INPUT -p tcp --dport 465 -j DROP && iptables -D FORWARD -m string --algo bm --string "BitTorrent" -j DROP && iptables -D FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP && iptables -D FORWARD -m string --algo bm --string "peer_id=" -j DROP && iptables -D FORWARD -m string --algo bm --string ".torrent" -j DROP && iptables -D FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP && iptables -D FORWARD -m string --algo bm --string "torrent" -j DROP && iptables -D FORWARD -m string --algo bm --string "announce" -j DROP && iptables -D FORWARD -m string --algo bm --string "info_hash" -j DROP && iptables -D FORWARD -m string --algo bm --string "/default.ida?" -j DROP && iptables -D FORWARD -m string --algo bm --string ".exe?/c+dir" -j DROP && iptables -D FORWARD -m string --algo bm --string ".exe?/c_tftp" -j DROP && iptables -D FORWARD -m string --string "peer_id" --algo kmp -j DROP && iptables -D FORWARD -m string --string "BitTorrent" --algo kmp -j DROP && iptables -D FORWARD -m string --string "BitTorrent protocol" --algo kmp -j DROP && iptables -D FORWARD -m string --string "bittorrent-announce" --algo kmp -j DROP && iptables -D FORWARD -m string --string "announce.php?passkey=" --algo kmp -j DROP && iptables -D FORWARD -m string --string "find_node" --algo kmp -j DROP && iptables -D FORWARD -m string --string "info_hash" --algo kmp -j DROP && iptables -D FORWARD -m string --string "get_peers" --algo kmp -j DROP && iptables -D FORWARD -m string --string "announce" --algo kmp -j DROP && iptables -D FORWARD -m string --string "announce_peers" --algo kmp -j DROP && iptables -D INPUT -m string --string "User-Agent: CheckHost" --algo bm --icase -j DROP && iptables -D INPUT -m string --string "User-Agent: CensysInspect" --algo bm --icase -j DROP && iptables -D INPUT -m string --string "User-Agent: Shodan" --algo bm --icase -j DROP && iptables -D INPUT -m string --string "User-Agent: SecurityTrails" --algo bm --icase -j DROP && iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
iptables -D INPUT -p tcp --dport 6881:6889 -j DROP
iptables -D INPUT -p udp --dport 6881:6889 -j DROP
iptables -D FORWARD -p tcp --dport 6881:6889 -j DROP
iptables -D FORWARD -p udp --dport 6881:6889 -j DROP
iptables -D INPUT -p udp --dport 33445 -j DROP
iptables -D FORWARD -p udp --dport 33445 -j DROP
iptables -D INPUT -p udp --dport 6881:7000 -j DROP
iptables -D FORWARD -p udp --dport 6881:7000 -j DROP
iptables -D INPUT -p tcp --dport 443 -m string --string "BitTorrent" --algo bm -j DROP
iptables -D INPUT -p udp --dport 443 -m string --string "BitTorrent" --algo bm -j DROP
iptables -D FORWARD -p tcp --dport 443 -m string --string "BitTorrent" --algo bm -j DROP
iptables -D FORWARD -p udp --dport 443 -m string --string "BitTorrent" --algo bm -j DROP
iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
modprobe -r xt_string
#===========#
sleep 2
iptables -A INPUT -p tcp --dport 25 -j DROP && iptables -A INPUT -p tcp --dport 465 -j DROP && iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP && iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP && iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP && iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP && iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP && iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP && iptables -A FORWARD -m string --algo bm --string "announce" -j DROP && iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP && iptables -A FORWARD -m string --algo bm --string "/default.ida?" -j DROP && iptables -A FORWARD -m string --algo bm --string ".exe?/c+dir" -j DROP && iptables -A FORWARD -m string --algo bm --string ".exe?/c_tftp" -j DROP && iptables -A FORWARD -m string --string "peer_id" --algo kmp -j DROP && iptables -A FORWARD -m string --string "BitTorrent" --algo kmp -j DROP && iptables -A FORWARD -m string --string "BitTorrent protocol" --algo kmp -j DROP && iptables -A FORWARD -m string --string "bittorrent-announce" --algo kmp -j DROP && iptables -A FORWARD -m string --string "announce.php?passkey=" --algo kmp -j DROP && iptables -A FORWARD -m string --string "find_node" --algo kmp -j DROP && iptables -A FORWARD -m string --string "info_hash" --algo kmp -j DROP && iptables -A FORWARD -m string --string "get_peers" --algo kmp -j DROP && iptables -A FORWARD -m string --string "announce" --algo kmp -j DROP && iptables -A FORWARD -m string --string "announce_peers" --algo kmp -j DROP && iptables -A INPUT -m string --string "User-Agent: CheckHost" --algo bm --icase -j DROP && iptables -A INPUT -m string --string "User-Agent: CensysInspect" --algo bm --icase -j DROP && iptables -A INPUT -m string --string "User-Agent: Shodan" --algo bm --icase -j DROP && iptables -A INPUT -m string --string "User-Agent: SecurityTrails" --algo bm --icase -j DROP && iptables-save > /etc/iptables.up.rules && iptables-restore -t < /etc/iptables.up.rules && netfilter-persistent save && netfilter-persistent reload
#===========#
clear
echo -e "${green}SUCCESS !${NC}"
#
clear
rm -rf .bash_history
echo "1.1.8" > /home/ver