FROM ubuntu:14.04
MAINTAINER Kristian Spriggs @knspriggs on GitHub

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

WORKDIR /src

ENV GIT_CLONE_DEPTH 2

RUN git clone --depth $GIT_CLONE_DEPTH  https://github.com/apple/swift.git swift
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-llvm.git llvm
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-clang.git clang
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-lldb.git lldb
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-cmark.git cmark
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-llbuild.git llbuild
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-package-manager.git swiftpm
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-corelibs-xctest.git
RUN git clone --depth $GIT_CLONE_DEPTH https://github.com/apple/swift-corelibs-foundation.git

RUN ./swift/utils/build-script --lldb --llbuild --swiftpm --xctest --foundation --make
