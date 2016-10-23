FROM alpine:edge
MAINTAINER tim van Dijk

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates \
        py2-pip git python py-libxml2 py-lxml \
        make gcc g++ python-dev openssl-dev libffi-dev unrar \
        && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade pyopenssl cheetah requirements && \
    git clone --depth 1 https://github.com/SickRage/SickRage.git /sickrage && \
    apk del make gcc g++ python-dev && \
    rm -rf /tmp && \
    rm -rf /var/cache/apk/*

ADD ./start.sh /tmp/start.sh
RUN chmod u+x /tmp/start.sh
RUN cp /tmp/start.sh / && rm -f /tmp/start.sh

VOLUME ["/config", "/data", "/cache"]

EXPOSE 8081

CMD ["/start.sh"]
