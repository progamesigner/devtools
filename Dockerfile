FROM alpine:3.21.2

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        apache2-utils \
        bash \
        bind-tools \
        bind-tools \
        bird \
        bridge-utils \
        busybox-extras \
        conntrack-tools \
        coreutils \
        cpio \
        ctop \
        curl \
        dhcping \
        diffutils \
        drill \
        ethtool \
        ethtool \
        file\
        findutils \
        fping \
        git \
        htop \
        httpie \
        iftop \
        inetutils-ftp \
        inetutils-telnet \
        iperf \
        iperf3 \
        iproute2 \
        ipset \
        iptables \
        iptraf-ng \
        iptstate \
        iputils \
        ipvsadm \
        jq \
        libc6-compat \
        liboping \
        lsof \
        ltrace \
        lynx \
        mtr \
        ncdu \
        net-snmp-tools \
        net-tools \
        netcat-openbsd \
        nftables \
        nghttp2 \
        ngrep \
        nmap \
        nmap-nping \
        nmap-scripts \
        openssh \
        openssl \
        perl-crypt-ssleay \
        perl-net-ssleay \
        psmisc \
        py3-pip \
        py3-setuptools \
        rsync \
        scapy \
        socat \
        speedtest-cli \
        strace \
        sysstat \
        tcpdump \
        tcptraceroute \
        termshark \
        tree \
        tshark \
        unzip \
        util-linux \
        vim \
        websocat \
        wget \
        zsh

USER root

WORKDIR /root

RUN chmod -R g=u /root

CMD ["zsh"]
