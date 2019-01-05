FROM ubuntu:18.04

RUN apt update && \
    apt install -y dh-autoreconf curl zip cmake python python-pip virtualenv python3 python3-dev python3-sip-dev python3-setuptools

# Install protobuf
RUN curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/protobuf-python-3.6.1.zip && \
    unzip protoc.zip && \
    cd protobuf-3.6.1 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install && \
    cd python && \
    python3 setup.py build && \
    python3 setup.py install && \
    ldconfig && \
    cd /

# Install libArcus
RUN curl -L -o libArcus.zip https://github.com/Ultimaker/libArcus/archive/2.7.0.zip && \
    unzip libArcus.zip && \
    cd libArcus-2.7.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install && \
    ldconfig

# Install CuraEngine
RUN curl -L -o cura-engine.zip https://github.com/Ultimaker/CuraEngine/archive/2.7.0.zip && \
    unzip cura-engine.zip && \
    cd CuraEngine-2.7.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    cd /

# Install OctoPrint
RUN curl -L -o octo-print.zip https://github.com/foosel/OctoPrint/archive/1.3.10.zip && \
    unzip octo-print.zip && \
    cd OctoPrint-1.3.10 && \
    virtualenv venv && \
    ./venv/bin/python setup.py install

EXPOSE 5000
VOLUME ["/root/.octoprint"]
CMD /OctoPrint-1.3.10/venv/bin/octoprint --iknowwhatimdoing
