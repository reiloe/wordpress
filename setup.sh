#!/bin/bash

echo "A username and password are required to configure the database for WordPress"

read -rp "PLease input the username: " USERNAME
read -rsp "PLease input the password: " PASSWORD
echo ""
read -rsp "PLease retype the password: " RPASSWORD
echo ""

while [[ "$PASSWORD" != "$RPASSWORD" ]]
do
  echo
  echo "Passwords don't match"
  read -rsp "PLease input the password: " PASSWORD
  echo
  read -rsp "PLease retype the password: " RPASSWORD
done

confirm() {
  while true; do
    read -p "$1 (y/n): " -n 1 -r
    echo
    case $REPLY in
      [Yy] ) return 0;;
      [Nn] ) return 1;;
      * ) echo "Invalid key pressed.";;
    esac
  done
}

check_port_in_use() {
  if lsof -Pi :"$1" -sTCP:LISTEN -t >/dev/null ; then
    echo ""
    echo "Another service is running on port $1."
    echo "You have to change the port WordPress is running on."
    return 0
  else
    return 1
  fi
}

change_port() {
  read -rp "Please enter the port number on which you want to run WordPress: " PORT
  re='^[0-9]+$'
  while ! [[ $PORT =~ $re ]]  || [[ $PORT -lt 1024 ]]
  do
   echo "Error: You entered not a number or the port was less than 1024"
   read -rp "Please enter the port number on which you want to run WordPress: " PORT
  done

  if check_port_in_use "$PORT"; then
    change_port
  fi
}

PORT=8080

echo ""
echo "By default WordPress will run at port $PORT."
echo "Checking used ports..."
echo ""

if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null ; then
  echo "Another service is running on port $PORT."
  echo "You have to change the port WordPress is running on."
  change_port
else
  echo "Port $PORT is free and ready to use."
  if confirm "Do you want to change the port?"; then
    change_port
  fi
fi

if [ ! -d ".secrets" ]; then
  mkdir .secrets
fi

echo "${USERNAME}" > .secrets/db_user.txt
echo "${PASSWORD}" > .secrets/db_pass.txt
echo "WORDPRESS_PORT=$PORT" > .env

docker compose up