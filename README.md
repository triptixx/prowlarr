[hub]: https://hub.docker.com/r/loxoo/prowlarr
[mbdg]: https://microbadger.com/images/loxoo/prowlarr
[git]: https://github.com/triptixx/prowlarr
[actions]: https://github.com/triptixx/prowlarr/actions

# [loxoo/prowlarr][hub]
[![Layers](https://images.microbadger.com/badges/image/loxoo/prowlarr.svg)][mbdg]
[![Latest Version](https://images.microbadger.com/badges/version/loxoo/prowlarr.svg)][hub]
[![Git Commit](https://images.microbadger.com/badges/commit/loxoo/prowlarr.svg)][git]
[![Docker Stars](https://img.shields.io/docker/stars/loxoo/prowlarr.svg)][hub]
[![Docker Pulls](https://img.shields.io/docker/pulls/loxoo/prowlarr.svg)][hub]
[![Build Status](https://github.com/triptixx/prowlarr/workflows/docker%20build/badge.svg)][actions]

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
