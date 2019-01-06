FROM python:2-alpine

RUN apk add --no-cache git gcc g++ python2-dev linux-headers libexecinfo-dev make && \
    # Install CuraEngine
    git clone -b legacy https://github.com/Ultimaker/CuraEngine.git && \ 
    cd CuraEngine && \
    make && \
    cd / && \
    # Install OctoPrint
    git clone -b 1.3.10 https://github.com/foosel/OctoPrint.git && \ 
    cd /OctoPrint && \
    python /OctoPrint/setup.py install && \
    cp /CuraEngine/build/CuraEngine /usr/local/bin && \
    rm -rf /CuraEngine /OctoPrint && \
    apk del git gcc g++ python2-dev linux-headers libexecinfo-dev make

EXPOSE 5000
VOLUME ["/root/.octoprint"]
CMD /usr/local/bin/octoprint --iknowwhatimdoing
