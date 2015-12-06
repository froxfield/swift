FROM ubuntu:14.04
MAINTAINER Kristian Spriggs @knspriggs on GitHub

ENV SWIFT_VERSION 2.2-SNAPSHOT-2015-12-01-b
ENV SWIFT_PLATFORM ubuntu14.04

# need all these:
RUN apt-get update && apt-get install -y \
  git \
  cmake \
  ninja-build \
  clang-3.6 \
  uuid-dev \
  libicu-dev \
  icu-devtools \
  libbsd-dev \
  libedit-dev \
  libxml2-dev \
  libsqlite3-dev \
  swig \
  libpython-dev \
  libncurses5-dev \
  pkg-config \
  wget

RUN update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100
RUN update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100

RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
  gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift

WORKDIR /src

RUN SWIFT_ARCHIVE_NAME=swift-$SWIFT_VERSION-$SWIFT_PLATFORM && \
  SWIFT_URL=https://swift.org/builds/$(echo "$SWIFT_PLATFORM" | tr -d .)/swift-$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz && \
  wget $SWIFT_URL && \
  wget $SWIFT_URL.sig && \
  gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig && \
  tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 && \
  rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*

WORKDIR /
