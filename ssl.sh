git checkout nossl
docker compose up nginx -d
git checkout master
docker compose up certbot -d
docker compose up nginx -d

echo 'all done'
