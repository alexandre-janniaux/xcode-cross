FROM ubuntu:16.04

RUN apt-get update && apt-get install -y doxygen zip build-essential curl git cmake zlib1g-dev libpng-dev libxml2-dev gobjc python vim-tiny

WORKDIR /opt

RUN set -x && sh ./scripts/clang.sh

RUN set -x && sh ./scripts/xcbuild.sh

RUN set -x && sh ./scripts/tapi.sh

# -D_FORTIFY_SOURCE=0, since cctools/misc/libtool.c:2070 gets an incorrect
# guard. Alternatively, the code could be changed to use snprintf instead.
RUN set -x && sh ./scripts/cctools.sh

ARG XCODE_CROSS_SRC_DIR=.
ADD $XCODE_CROSS_SRC_DIR /opt/xcode-cross/

ARG XCODE_URL

RUN set -x \
  && curl -LO $XCODE_URL \
  && tar --warning=no-unknown-keyword -Jxf $(basename $XCODE_URL) \
  && rm $(basename $XCODE_URL)

RUN set -x \
  && cd Xcode.app \
  && /opt/xcode-cross/setup-toolchain.sh /opt/cctools /opt/clang

ENV DEVELOPER_DIR=/opt/Xcode.app

RUN /opt/xcode-cross/setup-symlinks.sh /opt/xcode-cross $DEVELOPER_DIR /opt/cctools

# Add the Xcode toolchain to the path, but after the normal path directories,
# to allow using the host compiler as usual (for cases that require compilation
# both for host and target at the same time).
ENV PATH=/opt/xcode-cross/bin:$PATH:$DEVELOPER_DIR/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:/opt/xcbuild/usr/bin:/opt/cctools/bin
