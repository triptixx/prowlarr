ARG ALPINE_TAG=3.18
ARG PROWLARR_VER=1.10.1.4058

FROM loxoo/alpine:${ALPINE_TAG} AS builder

ARG PROWLARR_VER

### install prowlarr
WORKDIR /output/prowlarr
RUN apk add --no-cache curl; \
    curl -fsSL "https://prowlarr.servarr.com/v1/update/nightly/updatefile?version=${PROWLARR_VER}&os=linuxmusl&runtime=netcore&arch=x64" \
        | tar xz --strip-components=1; \
    find . -name '*.mdb' -delete; \
    find ./UI -name '*.map' -delete; \
    rm -r Prowlarr.Update

COPY *.sh /output/usr/local/bin/
RUN chmod +x /output/usr/local/bin/*.sh

#=============================================================

FROM loxoo/alpine:${ALPINE_TAG}

ARG PROWLARR_VER
ENV SUID=921 SGID=921

LABEL org.label-schema.name="prowlarr" \
      org.label-schema.description="A docker image for the torznab proxy Prowlarr" \
      org.label-schema.url="https://github.com/Prowlarr/Prowlarr" \
      org.label-schema.version=${PROWLARR_VER}

COPY --from=builder /output/ /

RUN apk add --no-cache libstdc++ libgcc libintl icu-libs sqlite-libs xmlstarlet

VOLUME ["/config"]

EXPOSE 9696/TCP

HEALTHCHECK --start-period=10s --timeout=5s \
    CMD wget -qO /dev/null 'http://localhost:9696/api/v1/system/status' \
            --header "x-api-key: $(xmlstarlet sel -t -v '/Config/ApiKey' /config/config.xml)"

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
CMD ["/prowlarr/Prowlarr", "--no-browser", "--data=/config"]
