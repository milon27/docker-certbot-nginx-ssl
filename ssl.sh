git checkout nossl
docker compose up nginx -d
git checkout master
docker compose up certbot

echo 'all done, restart nginx'

docker compose up nginx -d
