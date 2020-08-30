FROM ubuntu:18.04

ARG depends="python3 python3-dev python3-pip"

RUN apt update && apt install -y $depends

WORKDIR /opt/tmp

ADD . ./

RUN pip3 install . && \
    cd libs/libsvm/ && \
    tar -zxvf libsvm-3.18.tar.gz && \
    cd libsvm-3.18/ && \
    make clean && make && \
    cp -r * /usr/local/bin/ && \
    chmod +x /usr/local/bin/*

WORKDIR /opt

RUN rm -rf /opt/tmp/

CMD CPC2.py -h
