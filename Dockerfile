FROM alpine:latest

RUN echo "**** install Python ****" && \
    apk add --no-cache python3 && \
    if [ ! -e /usr/bin/python ]; then ln -sf python3 /usr/bin/python ; fi && \
    \
    echo "**** install pip ****" && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --no-cache --upgrade pip setuptools wheel && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    apk add --no-cache mariadb-dev libev-dev && \
    apk add --no-cache --virtual .build-deps gcc g++ musl-dev libffi-dev libev-dev libc-dev linux-headers python3-dev && \
    pip install --no-cache-dir mysqlclient bjoern whitenoise Brotli && \
    apk del .build-deps && \
    rm -Rf ~/.cache && \
    mkdir -p /project

COPY script/entrypoint.sh /entrypoint.sh

WORKDIR /project
ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]