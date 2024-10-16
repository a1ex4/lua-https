# Use an aarch64 base image
FROM arm64v8/ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y build-essential cmake lua5.1 luajit liblua5.1-0-dev libcurl4-openssl-dev g++ libssl-dev

# Copy your Lua library source code
COPY . /src
WORKDIR /src

# RUN cmake -Bbuild -S. -DCMAKE_INSTALL_PREFIX=$PWD/install -DCMAKE_BUILD_TYPE=Release -DUSE_CURL_BACKEND=${{ matrix.mode.curl }} -DUSE_OPENSSL_BACKEND=${{ matrix.mode.openssl }}
RUN cmake -Bbuild -S. -DCMAKE_INSTALL_PREFIX=$PWD/install -DCMAKE_BUILD_TYPE=Release -DUSE_CURL_BACKEND=1 -DUSE_OPENSSL_BACKEND=0

RUN cmake --build build --config Release --target install -j$(nproc)

# Set the output location
CMD cp /src/build/https-ubuntu.zip /https.so
