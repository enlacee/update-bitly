#!/bin/bash

## PUBLIC VARIABLES


# check local newtwork
STATUS=false
PACKAGES=$(ping -c 1 192.168.1.1 | grep % |awk '{print $6}')
PACKAGES_INTERNET=$(ping -c 1 www.google.com | grep % |awk '{print $6}')
WHAT_IS_MY_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
# echo $PACKAGES;

if [ "$PACKAGES" == '0%' ];
then
    STATUS=true
else
    STATUS=false
fi


if [ "$PACKAGES_INTERNET" == '0%' ];
then
    STATUS=true
else
    STATUS=false
fi

# Use API-BITLY for update the IP PUBLIC from my home server
function useAPIREST_PATH_bitly(){
    IP=$1

    BITLY_TOKEN=""
    BITLY_APIREST_URL="https://api-ssl.bitly.com/v4/bitlinks"
    URL_REQUEST="${BITLY_APIREST_URL}/bit.ly/2PdcQyi"
    DATE_NOW=$(date +'%Y-%m-%d %H:%M:%S')

    # echo $URL_REQUEST
    # echo $IP

    curl \
    -H "Authorization: Bearer ${BITLY_TOKEN}" \
    -H "Content-Type: application/json" \
    -X PATCH \
    -d "{"\""long_url"\"": "\""http://${IP}"\"", "\""title"\"": "\""http://${IP}  Last update: ${DATE_NOW} "\"" }" \
    $URL_REQUEST
}

# 
# Call Function
# 
useAPIREST_PATH_bitly "$WHAT_IS_MY_IP"


# use when status is FALSE: 1)no hay coneccion de red local 2)no hay coneccion a internet
if [ "$STATUS" = false ];
then
    echo "primera vez";
    ROUTER_RESET=true
    echo $STATUS
fi



if [ "$ROUTER_RESET" = true ];
then
    echo "actualizaa API"
fi
