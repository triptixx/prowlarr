[hub]: https://hub.docker.com/r/loxoo/prowlarr
[git]: https://github.com/triptixx/prowlarr/tree/master
[actions]: https://github.com/triptixx/prowlarr/actions/workflows/main.yml

# [loxoo/prowlarr][hub]
[![Git Commit](https://img.shields.io/github/last-commit/triptixx/prowlarr/master)][git]
[![Build Status](https://github.com/triptixx/prowlarr/actions/workflows/main.yml/badge.svg?branch=master)][actions]
[![Latest Version](https://img.shields.io/docker/v/loxoo/prowlarr/latest)][hub]
[![Size](https://img.shields.io/docker/image-size/loxoo/prowlarr/latest)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/prowlarr.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/prowlarr.svg)][hub]

## Usage

```shell
docker run -d \
    --name=srvprowlarr \
    --restart=unless-stopped \
    --hostname=srvprowlarr \
    -p 9696:9696 \
    -v $PWD/config:/config \
    loxoo/prowlarr
```

## Environment

- `$API_KEY`      - API Key authentication. _optional_
- `$ANALYTICS`    - Enable send Anonymous Usage Data. _default: `false`_
- `$BRANCH`       - Upstream tracking branch for updates. _default: `master`_
- `$ENABLE_SSL`   - Enable SSL. _default: `false`_
- `$LOG_LEVEL`    - Logging severity levels. _default: `info`_
- `$URL_BASE`     - URL Base configuration. _optional_
- `$SUID`         - User ID to run as. _default: `932`_
- `$SGID`         - Group ID to run as. _default: `900`_
- `$TZ`           - Timezone. _optional_

## Volume

- `/config`       - Server configuration file location.

## Network

- `9696/tcp`      - WebUI.
