#!/bin/bash

declare -a list
list[0]=google.com
list[1]=perdu.com
list[2]=laredoute.fr
list[3]=yahoo.com
list[4]=xkcd.com
list[5]=arstechnica.com
list[6]=www.wired.com
list[7]=sfr.fr
list[8]=actu.fr
list[9]=wanadoo.fr

# This part is to retrieve the latency of site the array and put it in the array like this : {latency}ms = {site}
array=$(for i in "${list[@]}"; do ping -c 1 $i |  egrep -o "([0-9.]+) ms$" -m 1 | sed -n -e "s/ms/ms = ${i}/p" ; done)

# Sorting the array
IFS=$'\n' sorted=($(sort -n <<<"${array[*]}")); unset IFS

# This part is just to reverse the latency and the host
for i in "${sorted[@]}"; do echo $i | sed -E "s/([0-9.]+ ms) = ([a-z.]+)/\2 : \1/" ; done
