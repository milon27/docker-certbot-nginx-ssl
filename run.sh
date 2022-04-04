#!/bin/bash
docker compose -f docker-compose.dev.yml up -d
# read -p "If site is live, Press enter to continue"
# curl -sL -w "%{http_code}\n" "http://m27lab.ml/" -o /dev/null output is 200

sleep 7

VARI=$(curl -sL -w "%{http_code}\n" "http://m27lab.ml/" -o /dev/null)

echo "response = $VARI"

# until [ $VARI == "200" ]
# do
#   sleep 5
#   echo "response = $VARI"
# done

echo "loop done,go next"
docker compose up certbot
# echo 'all done, restart nginx'
docker compose up nginx -d