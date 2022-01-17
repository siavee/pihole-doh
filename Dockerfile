FROM pihole/pihole

EXPOSE 53:53/tcp 53:53/udp 67:67/udp 80:80/tcp

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y autoremove --purge \
    && apt-get -y install wget \
    && wget https://github.com/DNSCrypt/dnscrypt-proxy/releases/download/2.1.1/dnscrypt-proxy-linux_x86_64-2.1.1.tar.gz \
    && tar xzfv dnscrypt-proxy-linux_x86_64-2.1.1.tar.gz \
    && mv linux-x86_64 dnscrypt-proxy \
    && mv dnscrypt-proxy /opt
    
COPY ./dnscrypt-proxy.toml /opt/dnscrypt-proxy/dnscrypt-proxy.toml
    
COPY ./startup /etc/startup

RUN mkdir -p /etc/pihole-doh/logs/pihole \
    && chmod +x /etc/startup

ENTRYPOINT ["/etc/startup"]
