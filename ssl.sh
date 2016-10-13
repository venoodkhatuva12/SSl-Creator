#!/bin/bash
#Script made for SSL Creation
#Author: Vinod.N K
#Usage: OpenSSL, Gcc, for SSL Cert Creation
#Distro : Linux -Centos, Rhel, and any fedora
#Check whether root user is running the script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
# Installing needed dependencies
sudo yum install gcc openssl openssl-devel pcre-devel git unzip -y
sudo mkdir -p /apps/certificate
cd /apps/certificate
sudo openssl genrsa -des3 -out server.key 2048

sudo openssl req -new -key server.key -out server.csr

sudo cp server.key server.key.org
sudo openssl rsa -in server.key.org -out server.key
sudo openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

#Changing name of key and crt
read -p "Whasts the Hostname ?" host
mv server.key $host.key
mv server.key.org $host.key.org
mv server.csr $host.csr
mv server.crt $host.crt
rm -rf /tmp/ssl.sh
