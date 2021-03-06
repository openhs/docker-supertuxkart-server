# Dockerfile
#
# Project: supertuxkart-server
# License: GNU GPLv3
#
# Copyright (C) 2020 Robert Cernansky



FROM debian:10 AS base



MAINTAINER openhs
LABEL version = "0.0.1" \
      description = "SuperTuxKart server"



RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    zlib1g openssl libcurl4 libenet7 procps

RUN apt-get clean

FROM base AS builder

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    build-essential cmake pkg-config zlib1g-dev libssl-dev libcurl4-openssl-dev libenet-dev git subversion \
    ca-certificates

RUN git clone -b 1.1 --depth 1 https://github.com/supertuxkart/stk-code.git
RUN svn co https://svn.code.sf.net/p/supertuxkart/code/stk-assets stk-assets
#COPY stk-code stk-code
#COPY stk-assets stk-assets

RUN cd stk-code && \
    mkdir build && \
    cd build && \
    cmake .. -DSERVER_ONLY=ON -DUSE_SYSTEM_ENET=ON && \
    make -j$(nproc) && \
    make install

FROM base

COPY --from=builder /usr/local /usr/local

RUN useradd --shell /bin/false --create-home stk

EXPOSE 2759/udp

USER stk
ENTRYPOINT ["/usr/local/bin/supertuxkart"]
