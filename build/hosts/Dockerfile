FROM fedora:38

ENV container docker

RUN dnf update -y

RUN dnf install -y net-tools iperf3 vim lldpad nmap iputils

COPY iperf3client.sh /usr/bin/iperf3client

COPY ipnet.sh /usr/bin/ipnet

RUN chmod +x /usr/bin/iperf3client

RUN chmod +x /usr/bin/ipnet

CMD ["/sbin/init"]