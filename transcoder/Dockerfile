FROM openjdk:8-jdk-alpine

RUN apk add --no-cache \
        bash \
        build-base \
        python-dev \
        wget \
        curl \
        ffmpeg \
        py-pip
COPY transcoder/tweb-0.3.2.tar.gz /tmp
RUN \
    pip install --upgrade b2 && \
    pip install /tmp/tweb-0.3.2.tar.gz && \
    rm /tmp/tweb-0.3.2.tar.gz
