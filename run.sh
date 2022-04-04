#!/bin/bash
docker compose -f docker-compose.dev.yml up -d
# read -p "If site is live, Press enter to continue"
# curl -sL -w "%{http_code}\n" "http://m27lab.ml/" -o /dev/null output is 200

VARI=$(curl -sL -w "%{http_code}\n" "http://m27lab.ml/" -o /dev/null)
echo "response = $VARI"

until [ $VARI == "200" ]
do
  sleep 3
  VARI=$(curl -sL -w "%{http_code}\n" "http://m27lab.ml/" -o /dev/null)
  echo "3 second later res = $VARI"
done

echo "loop done, get the ssl"
docker compose up certbot
# echo 'all done, restart nginx'
# docker compose up nginx -d
docker compose up --scale certbot=0 -d