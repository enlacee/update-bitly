#!/bin/bash

## PUBLIC VARIABLES
THERE_IS_INTERNET=false
PACKAGES=$(ping -c 1 192.168.1.1 | grep % |awk '{print $6}')
PACKAGES_INTERNET=$(ping -c 1 www.google.com | grep % |awk '{print $6}')
WHAT_IS_MY_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

# if [ "$PACKAGES" == '0%' ];
# then
#     THERE_IS_INTERNET=true
# else
#     THERE_IS_INTERNET=false
# fi

if [ "$PACKAGES_INTERNET" == '0%' ];
then
    THERE_IS_INTERNET=true
else
    THERE_IS_INTERNET=false
fi

# Use API-BITLY for update the IP PUBLIC from my home server
function useAPIREST_PATH_bitly(){
    local IP=$1

    local BITLY_TOKEN=""
    local BITLY_APIREST_URL="https://api-ssl.bitly.com/v4/bitlinks"
    local URL_REQUEST="${BITLY_APIREST_URL}/bit.ly/2PdcQyi"
    local DATE_NOW=$(date +'%Y-%m-%d %H:%M:%S')

    # echo $URL_REQUEST
    # echo $IP

    curl \
    -H "Authorization: Bearer ${BITLY_TOKEN}" \
    -H "Content-Type: application/json" \
    -X PATCH \
    -d "{"\""long_url"\"": "\""http://${IP}"\"", "\""title"\"": "\""http://${IP}  Last update: ${DATE_NOW} "\"" }" \
    $URL_REQUEST
}

# Use APIREST
export UPDATE_API=`cat VAR_UPDATE_API.txt`
if [ "$UPDATE_API" == "1" ];
then
    # check if there is INTERNET for to use BITLY API
    if [ "$PACKAGES_INTERNET" == '0%' ];
    then
        # Call Function
        echo -e "=== Actualizaa API REST ===\n"
        useAPIREST_PATH_bitly "$WHAT_IS_MY_IP"
        UPDATE_API=0
        echo $UPDATE_API > VAR_UPDATE_API.txt
    fi  
fi

# Use when THERE_IS_INTERNET is FALSE: 1) no hay coneccion de red local 2) no hay coneccion a internet
# SI NO HAY CONECCION CREAR LA VARIABLE RESTART_ROUTER
if [ "$THERE_IS_INTERNET" = false ];
then
    echo -e "=== No hay Internet ===\n"
    UPDATE_API=1
    echo $UPDATE_API > VAR_UPDATE_API.txt
fi