git checkout nossl
docker compose up nginx -d
read -p "If site is live, Press enter to continue"

# until $(curl --output /dev/null --silent --head --fail http://testmess27.ml/); do
#   printf 'waiting...'
#   sleep 5
# done

git checkout master
docker compose up certbot

echo 'all done, restart nginx'
docker compose up nginx -d
