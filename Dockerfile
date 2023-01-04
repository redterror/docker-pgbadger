FROM alpine:latest

LABEL maintainer="Rui Marinho <rui@uphold.com> (@ruimarinho)"

ENV PGBADGER_DATA=/data
ENV PGBADGER_VERSION=12.0
ENV PGBADGER_PREFIX=/opt/pgbadger-${PGBADGER_VERSION}
ENV PATH=${PGBADGER_PREFIX}:$PATH

RUN apk --no-cache add coreutils \
    gzip \
    openssl \
    perl \
    perl-text-csv_xs \
    perl-json-xs \
  && mkdir -p /data /opt \
  && wget -O - https://github.com/darold/pgbadger/archive/v${PGBADGER_VERSION}.tar.gz | tar -zxvf - -C /opt \
  && chmod +x ${PGBADGER_PREFIX}/pgbadger

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME $PGBADGER_DATA

ENTRYPOINT ["/entrypoint.sh"]

CMD ["pgbadger"]
