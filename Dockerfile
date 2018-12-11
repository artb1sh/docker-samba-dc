FROM alpine:edge
MAINTAINER  Viktor Skachkov <artb1sh@yandex.ru>

#Install
RUN apk add --no-cache samba-dc samba-client samba-common samba-winbind-clients \
  # Remove default config data, if any
  && rm -rf /etc/samba \
  && rm -rf /var/lib/samba \
  && rm -rf /var/log/samba \
  # Create needed symbolic links
  && ln -s /samba/etc /etc/samba \
  && ln -s /samba/lib /var/lib/samba \
  && ln -s /samba/log /var/log/samba

#Ports
EXPOSE 37/udp \
  53 \
  88 \
  123/udp \
  135/tcp \
  137/udp \
  138/udp \
  139 \
  389 \
  445 \
  464 \
  636/tcp \
  49152-65535/tcp \
  3268/tcp \
  3269/tcp

#Volume config
VOLUME ["/samba"]

# Entrypoint
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["samba"]
