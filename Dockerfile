ARG ALPINE_TAG=3.20
ARG PROWLARR_VER=1.20.1.4603

FROM loxoo/alpine:${ALPINE_TAG} AS builder

ARG PROWLARR_VER

### install prowlarr
WORKDIR /output/prowlarr
RUN wget -O- https://github.com/Prowlarr/Prowlarr/releases/download/v${PROWLARR_VER}/Prowlarr.master.${PROWLARR_VER}.linux-musl-core-x64.tar.gz \
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
