FROM sameersbn/ubuntu:14.04.20150712

ENV SKYPE_USER=skype

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7212620B \
 && echo "deb http://archive.canonical.com/ trusty partner" >> /etc/apt/sources.list \
 && dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get install -y pulseaudio:i386 skype:i386 \
 && rm -rf /var/lib/apt/lists/*

COPY scripts /scripts
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
