#!/bin/bash
docker compose -f docker-compose.dev.yml up -d
# read -p "If site is live, Press enter to continue"
# curl -sL -w "%{http_code}\n" "http://testmess27.ml/" -o /dev/null output is 200

VARI=$(curl -sL -w "%{http_code}\n" "http://testmess27.ml/" -o /dev/null)

until [ $VARI == "200" ]
do
  sleep 2
  echo "response = $VARI"
done

echo "loop done,go next"
docker compose up certbot
echo 'all done, restart nginx'
docker compose up nginx -d