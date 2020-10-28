FROM centos:8

ENV container docker

RUN yum update -y

RUN yum install -y net-tools iperf3 vim 

COPY iperf3client.sh /usr/bin/iperf3client

COPY ipnet.sh /usr/bin/ipnet

RUN chmod +x /usr/bin/iperf3client

RUN chmod +x /usr/bin/ipnet

CMD ["ipnet"]