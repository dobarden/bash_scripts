#!/bin/bash

PS3="Your choice: "

select ITEM in "Domain IP" "NS server" "All DNS records" "HTTP header" "Expiry date" Quit
do
if [[ $REPLY -eq 1 ]]
then
        read -p "Enter the domain name: " domain
	host -t A $domain
elif [[ $REPLY -eq 2 ]]
then
        read -p "Enter the domain name: " domain
	host -t NS $domain
elif [[ $REPLY -eq 3 ]]
then
        read -p "Enter the domain name: " domain
	dig @8.8.8.8 $domain ANY
elif [[ $REPLY -eq 4 ]]
then
        read -p "Enter the domain name: " domain
	curl -I $domain
elif [[ $REPLY -eq 5 ]]
then
        read -p "Enter the domain name: " domain
	whois $domain | egrep 'paid-till:|Expiry Date:' | sed 's|^.* 20|20|'
elif [[ $REPLY -eq 6 ]]
then
	echo "Bye..."
	exit
else
	echo "Invalid menu selection."
fi
done
