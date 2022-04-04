
## how to use
1. first setup the github action runner(self hosted)
2. push to github and run init.sh in the action

```bash
# docker.yml

name: Docker CI

on:
  push:
    branches: [ dev ]
  pull_request:
    branches: [ dev ]

jobs:
  # build if required.
  # build:
  #   runs-on: ubuntu-latest
  #   steps:
  #     - uses: actions/checkout@v3
  #     - name: docker hub login
  #       env: 
  #         DOCKER_USER: ${{secrets.DOCKER_USER}}
  #         DOCKER_PASS: ${{secrets.DOCKER_PASS}}
  #       run: |
  #         docker login -u $DOCKER_USER -p $DOCKER_PASS 
  #     - name: build the images
  #       run: |
  #         docker compose build
  #     - name: docker hub push
  #       run: |
  #         docker compose push

  # deploy now
  deploy:
    runs-on: [self-hosted, prod]
    steps:
    - uses: actions/checkout@v3
    - name: pull the iamges(if required) & run using run.sh script
      run: bash init.sh
      # run: bash run.sh
      # run: |
      #   docker compose pull
      #   docker compose up -d

```

> init.sh will do following things

- run the container without ssl or port 80
- wait until containe is started and site is accessable in port 80
- get the certbot ssl when site is available on http
- run all the service except certbot in background.
- your site is live on https 😎



3. now setup the regular ci/cd 
4. push to github again and run without the ssl setup for that run run.sh instead of init.sh in the action

```bash
# docker.yml

name: Docker CI

on:
  ...

jobs:
  # build if required.
  build:
    ...

  # deploy now
  deploy:
    runs-on: [self-hosted, prod]
    steps:
    - uses: actions/checkout@v3
    - name: pull the iamges(if required) & run using run.sh script
      run: bash run.sh
      # run: bash run.sh

```








#### some other things

generate open ssl and put in the dhparam folder

```bash
# cd dhparam && run bellow command
openssl dhparam  -out ./dhparam-2048.pem 2048
```

renew in crontab
```
 docker compose run --rm certbot renew
 or

 crontab -e
 0 5 1 */2 *  /usr/local/bin/docker-compose up -f /var/docker/docker-compose.yml certbot
```
