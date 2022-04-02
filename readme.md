generate open ssl

```
openssl dhparam  -out ./dhparam-2048.pem 2048
```

renew in crontab
```
 docker compose run --rm certbot renew
 or

 crontab -e
 0 5 1 */2 *  /usr/local/bin/docker-compose up -f /var/docker/docker-compose.yml certbot
```

## how to use
```bash
# go to nossl branch
 git checkout nossl
 docker compose up nginx -d

# go to master branch
git checkout master
docker compose up certbot -d
docker compose up nginx -d
# done..
```