#!/bin/sh

QRC_DEST='/tmp/qrc'

if ! [ -z "$HA_KEY" ] ; then
  echo "Install public key ..."
  if ! [ -d ~/.ssh ] ; then
    mkdir ~/.ssh
  fi
  echo $HA_KEY >> ~/.ssh/authorized_keys
fi


if command -v curl > /dev/null; then
  HTTP='curl -sL '

elif command -v wget > /dev/null; then
  HTTP='wget -qO- '

else
  echo "curl or wget required"
  exit 1
fi


IP=$($HTTP ipinfo.io/ip)
PORT=${SSH_CLIENT##* }

echo "Connection Config"
echo "-----------------------"
echo "IP\t" ":" $IP
echo "PORT\t" ":" $PORT
echo "USER\t" ":" $(whoami)
echo "-----------------------"



if ! [ -f /tmp/qrc ]; then
  echo "\nDownloading QR tool [2.72M] ..."

  command -v curl > /dev/null && curl -o /tmp/qrc -sL https://github.com/fumiyas/qrc/releases/download/v0.1.1/qrc_linux_amd64 && chmod +x /tmp/qrc

  command -v curl > /dev/null || command -v wget > /dev/null && wget -qO /tmp/qrc https://github.com/fumiyas/qrc/releases/download/v0.1.1/qrc_linux_amd64 && chmod +x /tmp/qrc

fi



echo "\nPlease scan QR using HyperApp:\n\n"

echo "ssh://$(whoami)@$IP:$PORT" | /tmp/qrc
