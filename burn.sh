#!/bin/bash

source ./network.sh


echo "Burning for target=${MIX_TARGET} ssid=${NETWORK_SSID} pw=${NETWORK_PW}"

mix firmware
