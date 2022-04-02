git checkout nossl
docker compose up nginx -d
read -p "If site is live, Press enter to continue"
git checkout master
docker compose up certbot

echo 'all done, restart nginx'

# docker compose up nginx -d
