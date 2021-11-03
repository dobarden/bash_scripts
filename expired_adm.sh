#!/bin/bash

read -p "File with domains: " ip_list_file

while read domain
do
echo "----------"
echo -n "$domain: "
expdate=$(whois $domain | egrep 'paid-till:|Expiry Date:' | sed 's|^.* 20|20|')
echo "$expdate"
sleep 7
done < "$ip_list_file"
echo "----------"
