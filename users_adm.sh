#!/bin/bash

function read_user () {
	read -p "Enter the username: " username
	output="$(grep -w $username /etc/passwd)"
}

PS3="Enter the menu number: "
select ITEM in "Add user" "Delete user" "List of Users" "List of user groups" "Account information" Quit
do

if [[ $REPLY -eq 1 ]]
then
        read_user
        if [[ -n "$output" ]]
        then
                echo "The username $username already exists."
        else
                sudo useradd -m -s /bin/bash "$username"
                sudo passwd "$username"
                if [[ $? -eq 0 ]]
                then
                        echo "The user $username was added successfully."
                        tail -n 1 /etc/passwd
                else
                        echo "There was an error adding the user $username."
                fi
        fi

elif [[ $REPLY -eq 2 ]]
then
        read_user
        if [[ -z "$output" ]]
        then
                echo "The user $username does NOT exists."
        else
                sudo userdel --remove "$username"
                if [[ $? -eq 0 ]]
                then
                        echo "The user $username was deleteded successfully."
                else
                        echo "There was an error deleting the user $username."
                fi
        fi

elif [[ $REPLY -eq 3 ]]
then
        echo "Users list"
        cut -f1 -d: /etc/passwd | sort | cat -n

elif [[ $REPLY -eq 4 ]]
then
        read_user
        if [[ -z "$output" ]]
        then
                echo "The user $username does NOT exists."
        else
                echo "Listing of $username groups"
                groups $username
        fi

elif [[ $REPLY -eq 5 ]]
then
        read_user
        if [[ -z "$output" ]]
        then
                echo "The user $username does NOT exists."
        else
				echo "The user $username account status information."
				sudo passwd --status $username
        fi

elif [[ $REPLY -eq 6 ]]
then
        echo "Quitting..."
        sleep 1
        exit
else
        echo "Invalid menu selection."
fi
done
