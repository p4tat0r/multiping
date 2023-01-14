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

array=$(for i in "${list[@]}"; do ping -c 1 $i |  egrep -o "([0-9.]+) ms$" -m 1 | sed -n -e "s/ms/ms = ${i}/p" ; done)
IFS=$'\n' sorted=($(sort -n <<<"${array[*]}")); unset IFS
for i in "${sorted[@]}"; do echo $i | sed -E "s/([0-9.]+ ms) = ([a-z.]+)/\2 : \1/" ; done
