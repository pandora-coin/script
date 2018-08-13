#!/bin/bash
echo -e "\e[31minstalling libraries...\e[0m"
{
sudo apt-get -y update
} &> /dev/null
echo -ne '[##                 ]  (10%)\r'
{
sudo apt-get -y upgrade
} &> /dev/null
echo -ne '[####               ] (20%)\r'
{
sudo apt-get --force-yes -y install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
} &> /dev/null
echo -ne '[######             ] (30%)\r'
{
sudo apt-get --force-yes -y install libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev
} &> /dev/null
echo -ne '[#######            ] (40%)\r'
{
sudo add-apt-repository -y ppa:bitcoin/bitcoin
sudo apt-get -y update
} &> /dev/null
echo -ne '[#########          ] (50%)\r'
{
sudo apt-get --force-yes -y install libdb4.8-dev libdb4.8++-dev
sudo apt-get --force-yes -y install libminiupnpc-dev
} &> /dev/null
echo -ne '[###########        ] (60%)\r'
{
sudo apt-get --force-yes -y install libzmq3-dev
sudo apt-get --force-yes -y install libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
} &> /dev/null
echo -ne '[#############      ] (70%)\r'
{
sudo apt-get --force-yes -y install libqrencode-dev
sudo apt-get --force-yes -y install unzip
} &> /dev/null
echo -ne '[###############    ] (80%)\r'
{
if ! [ -d /root/linux ]; then
git clone https://github.com/pandora-coin/linux
fi
} &> /dev/null
echo -ne '[#################  ] (90%)\r'
{
cd /root/linux
unzip pandorad
chmod 777 pandorad
chmod 777 pandora-cli
./pandorad
} &> /dev/null
echo -ne '[###################] (100%)\n'
IP=''
PRIVKEY=''
RPC_USER=''
RPC_PASS=''
echo -n -e "\e[31mEnter rpcuser= : \e[0m\n"
read RPC_USER
echo -n -e "\e[31mEnter rpcpassword= : \e[0m\n"
read RPC_PASS
echo -n -e "\e[31mEnter IP address : \e[0m\n"
read IP
echo -e "\e[31mEnter PRIVATE_KEY : \e[0m"
read PRIVKEY
 cat << EOF > /root/.pandora/pandora.conf
rpcuser=$RPC_USER
rpcpassword=$RPC_PASS
rpcallowip=127.0.0.1
rpcport=17511
port=17510
listen=1
server=1
daemon=1
logtimestamps=1
maxconnections=256
masternode=1
externalip=$IP
bind=$IP
masternodeaddr=$IP
masternodeprivkey=$PRIVKEY
addnode=209.250.249.177
addnode=209.250.228.146
addnode=149.28.124.95
addnode=149.28.181.241
EOF
./pandorad
