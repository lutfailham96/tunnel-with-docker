FROM alpine:3.16 AS builder

RUN apk add --no-cache \
        git \
        gcc \
        cmake \
        make \
        libc6-compat \
        musl-dev \
      && git clone --depth=1 https://github.com/ambrop72/badvpn \
      && cd badvpn \
      && mkdir build \
      && cd build \
      && cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=0 -DBUILD_UDPGW=1 \
      && make -j$(nproc)

FROM alpine:3.16 AS runner

ENV UDPGW_PORT=7300 \
    LOGLEVEL=1

COPY --from=builder /badvpn/build/udpgw/badvpn-udpgw /usr/local/bin/
COPY start-udpgw.sh /start-udpgw.sh

EXPOSE 7300

ENTRYPOINT ["/start-udpgw.sh"]
