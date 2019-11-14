FROM centos:8

RUN yum update -y

RUN yum install -y net-tools iperf3

COPY iperf3client.sh /usr/bin/

CMD ["/sbin/init"]