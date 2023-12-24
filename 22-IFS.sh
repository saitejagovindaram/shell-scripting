#!/bin/bash

file=/etc/passwd

if [ ! -f $file ] # ! denotes opposite
then
    echo -e "Source directory: $file does not exists."
fi

while IFS=":" read -r username password user_id group_id user_fullname home_dir shell_path
do
    echo "username: $username"
    echo "user ID: $user_id"
    echo "User Full name: $user_fullname"
done < $file

