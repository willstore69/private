#!/usr/bin/env bash
if [[ $(ulimit -c) != "0" ]]; then
  echo "Im Watching You..."
  echo "- @user_legend"
  exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') ipinfo.io/ip)
if [ -z "$MYIP" ]; then
  MYIP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') http://ip-api.com/json | jq .query | tr -d '"')
fi
if [ -z "$MYIP" ]; then
  MYIP=$(curl -s --max-time 2 --interface $(ip route show default | awk '{print $5}') ipinfo.io | jq .ip | tr -d '"')
fi
if ! which wget > /dev/null; then
  clear
  echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
  sleep 2
  exit 0
fi
if ! which curl > /dev/null; then
  clear
  echo -e "${red}Wah Mau Belajar Nakal Yah !${NC}"
  sleep 2
  exit 0
fi
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
token='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'
permission_data=""
repogithub='willstore69/private/main'
repopermission='https://regist.scxwill.web.id/scvps/permission.txt'
permission_data=$(curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission)
if [ -z "$permission_data" ]; then
  repopermission='https://regist.myenemyisyours.my.id/scvps/permission.txt'
  permission_data=$(curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission)
fi
if [ -z "$permission_data" ]; then
  repopermission='http://yourenemy.scwill.my.id:8081/permission.txt'
  permission_data=$(curl -s -f -H 'Cache-Control: no-cache, no-store' -H 'X-ACCESS-KEY: sc by will69' $repopermission)
fi
user_line=$(echo "$permission_data" | grep -w "$MYIP")
if [ -z "$user_line" ]; then
  echo -e "${red}IP Address Not Found In Our Database${NC}"
  echo -e "Contact Admin : t.me/user_legend"
  exit 1
fi
echo -e "${green}IP Address Accepted${NC}"
clientname=$(cat /usr/local/etc/clientname)
checkclient=$(echo "$user_line" | awk '{print $2}')
if [[ "$clientname" = "$checkclient" ]]; then
  echo -e "${green}Client Name Accepted${NC}"
else
  echo -e "${red}Client Name Not Compatible !${NC}"
  echo -e "Contact Admin : t.me/user_legend"
  exit 1
fi
exp=$(echo "$user_line" | awk '{print $3}')
d1=$(date -d "$exp" +%s)
d2=$(date -d "$(date +%Y-%m-%d)" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" -le "0" ]]; then
  echo -e "${red}Script Expired!${NC}"
  echo -e "Contact Admin: t.me/user_legend"
  mkdir -p /etc/forbiddens/.disabled/
  mv /usr/bin/add* /etc/forbiddens/.disabled/
  mv /usr/bin/trial* /etc/forbiddens/.disabled/
  mv /usr/bin/renew* /etc/forbiddens/.disabled/
  mv /usr/bin/del* /etc/forbiddens/.disabled/
  mv /usr/bin/bckp* /etc/forbiddens/.disabled/
  mv /usr/bin/restore* /etc/forbiddens/.disabled/
  mv /usr/local/etc/xray/*json /etc/forbiddens/.disabled/
  echo -e "ID:\nSCRIPT EXPIRED GAN \nSILAHKAN PERPANJANG AGAR BISA DIAKSES LAGI\n\nENG:\nSCRIPT EXPIRED \nEXTEND TO CONTINUE USE SCRIPT" > /root/SCRIPT_EXPIRED_NIH_BACA_FILE_INI.txt
  chmod +x /root/SCRIPT_EXPIRED_NIH_BACA_FILE_INI.txt
  exit 1
else
  echo -e "${green}Script Active !${NC}"
  if [ "$(ls -A /etc/forbiddens/.disabled/)" ]; then
    mv /etc/forbiddens/.disabled/add* /usr/bin/
    mv /etc/forbiddens/.disabled/trial* /usr/bin/
    mv /etc/forbiddens/.disabled/renew* /usr/bin/
    mv /etc/forbiddens/.disabled/del* /usr/bin/
    mv /etc/forbiddens/.disabled/bckp* /usr/bin/
    mv /etc/forbiddens/.disabled/restore* /usr/bin/
    mv /etc/forbiddens/.disabled/*json /usr/local/etc/xray/
    rm -rf /etc/forbiddens/.disabled/
    rm -rf /root/SCRIPT_EXPIRED_NIH_BACA_FILE_INI.txt
  fi
  clear
fi

####

DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

####

#detail nama perusahaan
country=ID
state=Indonesia
locality=Indonesia
organization=william
organizationalunit=william
commonname=william
email=asistenwilliam@gmail.com

source /etc/os-release
release=$ID
os_version=$(cat /etc/os-release | grep -w "VERSION_ID" | awk -F'"' '{print $2}' | cut -d. -f1)

# install stunnel 5
if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -ge 22 ]]; then
echo "install STUNNEL5"
sleep 2
mkdir -p /etc/stunnel/
cd /root/
wget --no-check-certificate https://github.com/willstore69/update/raw/main/stunnel-5.70.tar.gz
tar -xzvf stunnel-5.70.tar.gz && rm -rf stunnel-5.70.tar.gz
cd stunnel-5.70 && rm -rf stunnel-5.70
./configure
make
make install
mv /usr/local/bin/stunnel /usr/local/bin/stunnel5
chmod +x /usr/local/bin/stunnel5
rm -rf /usr/local/bin/stunnel3
rm -rf /usr/local/bin/stunnel
touch /etc/stunnel/stunnel5.conf
touch /etc/stunnel/stunnel5.pem

# Download Config Stunnel5
cat > /etc/stunnel/stunnel.conf << END 
cert = /etc/stunnel/stunnel5.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear ws ssl]
accept = 6443
connect = 127.0.0.1:2052

[openvpn]
accept = 442
connect = 127.0.0.1:1194
END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel5.pem

#
apt-get install bc

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
Documentation=https://github.com/willstore69
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel/stunnel.conf
Type=forking
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget --no-check-certificate -O /etc/init.d/stunnel5 "https://raw.githubusercontent.com/scriptvpskita/list-version/main/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel/stunnel5.pem
chmod +x /etc/init.d/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4

# Restart Stunnel 5
systemctl enable stunnel5
systemctl stop stunnel5
systemctl start stunnel5
systemctl restart stunnel5
fi
fi

# install stunnel 5
if [[ "${release}" == "debian" ]]; then
if [[ "$os_version" -ge 11 ]]; then
echo "install STUNNEL5"
sleep 2
mkdir -p /etc/stunnel/
cd /root/
wget --no-check-certificate https://github.com/willstore69/update/raw/main/stunnel-5.70.tar.gz
tar -xzvf stunnel-5.70.tar.gz && rm -rf stunnel-5.70.tar.gz
cd stunnel-5.70 && rm -rf stunnel-5.70
./configure
make
make install
mv /usr/local/bin/stunnel /usr/local/bin/stunnel5
chmod +x /usr/local/bin/stunnel5
rm -rf /usr/local/bin/stunnel3
rm -rf /usr/local/bin/stunnel
touch /etc/stunnel/stunnel5.conf
touch /etc/stunnel/stunnel5.pem

# Download Config Stunnel5
cat > /etc/stunnel/stunnel.conf << END 
cert = /etc/stunnel/stunnel5.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear ws ssl]
accept = 6443
connect = 127.0.0.1:2052

[openvpn]
accept = 442
connect = 127.0.0.1:1194
END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel5.pem

# Service Stunnel5 systemctl restart stunnel5
cat > /etc/systemd/system/stunnel5.service << END
[Unit]
Description=Stunnel5 Service
Documentation=https://stunnel.org
Documentation=https://github.com/willstore69
After=syslog.target network-online.target

[Service]
ExecStart=/usr/local/bin/stunnel5 /etc/stunnel/stunnel.conf
Type=forking
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

# Service Stunnel5 /etc/init.d/stunnel5
wget --no-check-certificate -O /etc/init.d/stunnel5 "https://raw.githubusercontent.com/scriptvpskita/list-version/main/stunnel5.init"

# Ubah Izin Akses
chmod 600 /etc/stunnel/stunnel5.pem
chmod +x /etc/init.d/stunnel5

# Remove File
rm -r -f /usr/local/share/doc/stunnel/
rm -r -f /usr/local/etc/stunnel/
rm -f /usr/local/bin/stunnel
rm -f /usr/local/bin/stunnel3
rm -f /usr/local/bin/stunnel4

# Restart Stunnel 5
systemctl enable stunnel5
systemctl stop stunnel5
systemctl start stunnel5
systemctl restart stunnel5
fi
fi

sleep 3

echo "WAIT.."
source /etc/os-release
release=$ID
os_version=$(cat /etc/os-release | grep -w "VERSION_ID" | awk -F'"' '{print $2}' | cut -d. -f1)

if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -ge 22 ]]; then
apt -y reinstall sslh

cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --tls 127.0.0.1:1369 --openvpn 127.0.0.1:1194 --anyprot 127.0.0.1:109 --pidfile /var/run/sslh/sslh.pid
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start sslh
systemctl restart sslh
chmod 777 /var/run/sslh/sslh.pid
systemctl restart sslh
fi
fi

if [[ "${release}" == "debian" ]]; then
if [[ "$os_version" -ge 11 ]]; then
apt -y reinstall sslh
cat > /lib/systemd/system/sslh.service << END
[Unit]
Description=SSL/SSH multiplexer
After=network.target
Documentation=man:sslh(8)

[Service]
EnvironmentFile=/etc/default/sslh
ExecStart=/usr/sbin/sslh --foreground --user sslh --listen 0.0.0.0:443 --ssh 127.0.0.1:22 --tls 127.0.0.1:1369 --openvpn 127.0.0.1:1194 --anyprot 127.0.0.1:109 --pidfile /var/run/sslh/sslh.pid
KillMode=process
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl start sslh
systemctl restart sslh
chmod 777 /var/run/sslh/sslh.pid
systemctl restart sslh
fi
fi

# INSTALL OPENVPN FOR UBUNTU & DEBIAN HIGHER OS
if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -ge 22 ]]; then
apt-get install liblzo2-dev -y
apt install openvpn-systemd-resolved -y
sed -i 's|up /etc/openvpn/update-resolv-conf|up /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-tcp-1194.conf
sed -i 's|down /etc/openvpn/update-resolv-conf|down /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-tcp-1194.conf
sed -i 's|up /etc/openvpn/update-resolv-conf|up /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-udp-2200.conf
sed -i 's|down /etc/openvpn/update-resolv-conf|down /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-udp-2200.conf
systemctl restart openvpn-server@server-tcp-1194
systemctl restart openvpn-server@server-udp-2200
fi
fi

if [[ "${release}" == "debian" ]]; then
if [[ "$os_version" -ge 11 ]]; then
apt-get install liblzo2-dev -y
apt install openvpn-systemd-resolved -y
sed -i 's|up /etc/openvpn/update-resolv-conf|up /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-tcp-1194.conf
sed -i 's|down /etc/openvpn/update-resolv-conf|down /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-tcp-1194.conf
sed -i 's|up /etc/openvpn/update-resolv-conf|up /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-udp-2200.conf
sed -i 's|down /etc/openvpn/update-resolv-conf|down /etc/openvpn/update-systemd-resolved|g' /etc/openvpn/server/server-udp-2200.conf
systemctl restart openvpn-server@server-tcp-1194
systemctl restart openvpn-server@server-udp-2200
fi
fi

sleep 1

PYTHON_VERSION=$(python3 --version | awk '{print $2}')
PYTHON_MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
PYTHON_MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)
if [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -ge 11 ]; then
PIP_BREAK="--break-system-packages"
PIP_IGNORE="--ignore-installed"
else
PIP_BREAK=""
PIP_IGNORE=""
fi
apt update -y
apt install -y python3 python3-pip python3-dev libgrpc++-dev build-essential libssl-dev libz-dev
pip3 install --upgrade pip $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade setuptools $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade wheel $PIP_BREAK $PIP_IGNORE
python3 -m pip install --upgrade setuptools $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade pyopenssl $PIP_BREAK $PIP_IGNORE
pip3 install cffi $PIP_BREAK $PIP_IGNORE
pip3 install cryptography $PIP_BREAK $PIP_IGNORE
pip3 install telegram $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade pip $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade setuptools $PIP_BREAK $PIP_IGNORE
pip3 install --upgrade wheel $PIP_BREAK $PIP_IGNORE
pip3 uninstall -y python-telegram-bot
pip3 install python-telegram-bot==21.4 $PIP_BREAK $PIP_IGNORE
pip3 install nest_asyncio==1.6.0 $PIP_BREAK $PIP_IGNORE
pip3 install aiohttp==3.10.3 $PIP_BREAK $PIP_IGNORE
pip3 install uvicorn==0.34.0 $PIP_BREAK $PIP_IGNORE
pip3 install fastapi==0.115.8 $PIP_BREAK $PIP_IGNORE
pip3 install flask $PIP_BREAK $PIP_IGNORE
pip3 install waitress $PIP_BREAK $PIP_IGNORE
pip3 install telegram $PIP_BREAK $PIP_IGNORE
pip3 install requests $PIP_BREAK $PIP_IGNORE
pip3 install gdown $PIP_BREAK $PIP_IGNORE
source /etc/os-release
release=$ID
os_version=$(grep -w "VERSION_ID" /etc/os-release | awk -F'"' '{print $2}' | cut -d. -f1)
if [[ "${release}" == "ubuntu" && "$os_version" -ge 25 ]]; then
apt install -y python3.13-dev
python3.13 -m pip install --upgrade pip $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install --upgrade setuptools $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install --upgrade wheel $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install --upgrade packaging $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install --upgrade Cython $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install --upgrade flit_core $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install grpcio $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install grpcio-tools $PIP_BREAK $PIP_IGNORE
python3.13 -m pip install protobuf $PIP_BREAK $PIP_IGNORE
pip3 install xtlsapi==3.1.2 --no-deps $PIP_BREAK $PIP_IGNORE
fi
pip3 install grpcio==1.71.2 $PIP_BREAK $PIP_IGNORE
pip3 install grpcio-tools==1.71.2 $PIP_BREAK $PIP_IGNORE
pip3 install protobuf==5.28.3 $PIP_BREAK $PIP_IGNORE
pip3 install xtlsapi==3.1.2 $PIP_BREAK $PIP_IGNORE
pip3 show xtlsapi | grep Version
pip3 show grpcio-tools | grep Version
pip3 show protobuf | grep Version
pip3 show grpcio | grep Version

if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -eq 18 ]]; then
wget -q http://archive.ubuntu.com/ubuntu/pool/main/n/ncurses/libtinfo6_6.2-0ubuntu2_amd64.deb
dpkg -i libtinfo6_6.2-0ubuntu2_amd64.deb
ldconfig
rm -rf /root/libtinfo6_6.2-0ubuntu2_amd64.deb
fi
fi

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

# tcp bbr
KERNEL_VERSION=$(uname -r | cut -d'-' -f1)
version_ge() {
  [ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" ]
}
if version_ge "$KERNEL_VERSION" "4.9"; then
declare -A settings=(
  ["net.ipv4.ip_forward"]="1"
  ["net.ipv4.tcp_congestion_control"]="bbr"
  ["net.core.default_qdisc"]="fq"
)
SYSCTL_FILE="/etc/sysctl.conf"
for key in "${!settings[@]}"; do
  value="${settings[$key]}"
  if grep -q "^[#]*\s*$key" "$SYSCTL_FILE"; then
    sed -i "s|^[#]*\s*$key.*|$key = $value|" "$SYSCTL_FILE"
  else
    echo "$key = $value" >> "$SYSCTL_FILE"
  fi
done
sysctl -p
else
  echo "Kernel versi $KERNEL_VERSION terlalu rendah. di-skip."
fi

sleep 1

source /etc/os-release
release=$ID
os_version=$(cat /etc/os-release | grep -w "VERSION_ID" | awk -F'"' '{print $2}' | cut -d. -f1)

if [[ "${release}" == "ubuntu" ]]; then
if [[ "$os_version" -ge 24 ]]; then
apt purge dropbear dropbear-bin -y
apt clean
rm -rf /var/lib/apt/lists/*
apt update && apt install -y build-essential zlib1g-dev
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2019.78.tar.bz2 && tar -xvf dropbear-2019.78.tar.bz2 && cd dropbear-2019.78 && ./configure && make && make install && dropbear

rm -rf /usr/sbin/dropbear
mv /usr/local/sbin/dropbear /usr/sbin/dropbear
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ldconfig

cat > /etc/default/dropbear << END 
NO_START=0
DROPBEAR_PORT=143
DROPBEAR_EXTRA_ARGS="-p 109"
DROPBEAR_BANNER="/etc/issue.net"
DROPBEAR_RECEIVE_WINDOW=65536
END

cat > /lib/systemd/system/dropbear.service << END 
[Unit]
Description=Lightweight SSH server
Documentation=man:dropbear(8)
After=network.target

[Service]
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
Environment=DROPBEAR_PORT=22 DROPBEAR_RECEIVE_WINDOW=65536
EnvironmentFile=-/etc/default/dropbear
ExecStart=/usr/sbin/dropbear -EF -p "143" -W "65536" -p 109 -b /etc/issue.net
KillMode=process
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
END

echo "restart dropbear"
sleep 2
mkdir -p /etc/dropbear
chmod 700 /etc/dropbear
dropbearkey -t dss -f /etc/dropbear/dropbear_dss_host_key
systemctl daemon-reload
systemctl enable dropbear
systemctl start dropbear
systemctl restart dropbear
/usr/sbin/dropbear -V
fi
fi

apt install nano