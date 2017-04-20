#!/bin/sh

QRC_DEST='/tmp/qrc'

if command -v curl > /dev/null; then
  HTTP='curl -sL '

elif command -v wget > /dev/null; then
  HTTP='wget -qO- '

else
  echo "curl or wget required"
  exit 1
fi


IP=$($HTTP ipinfo.io/ip)
echo "Connection Config"
echo "-----------------------"
echo "IP\t" ":" $IP
echo "PORT\t" ":" ${SSH_CLIENT##* }
echo "USER\t" ":" $(whoami)
echo "-----------------------"



if ! [ -f /tmp/qrc ]; then
  echo "\nDownloding QR tool [2.72M] ..."

  command -v curl > /dev/null && curl -o /tmp/qrc -sL https://github.com/fumiyas/qrc/releases/download/v0.1.1/qrc_linux_amd64 && chmod +x /tmp/qrc

  command -v curl > /dev/null || command -v wget > /dev/null && wget -qO /tmp/qrc https://github.com/fumiyas/qrc/releases/download/v0.1.1/qrc_linux_amd64

fi



echo "\nPlease scan QR using HyperApp:\n\n"

echo "ssh://$(whoami):$HA_KEY@$IP" | /tmp/qrc
