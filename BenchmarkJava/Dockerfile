# This dockerfile builds a container that pulls down and runs the latest version of Benchmark
FROM ubuntu:latest
MAINTAINER "Dave Wichers dave.wichers@owasp.org"

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN apt-get install -q -y \
     openjdk-8-jre-headless \
     openjdk-8-jdk \
     git \
     maven \
     wget \
     curl \
     iputils-ping \
     && apt-get clean

WORKDIR /opt/
COPY . .
RUN unzip git.zip && git clone https://github.com/OWASP-Benchmark/BenchmarkUtils.git && cd BenchmarkUtils && mvn install
RUN cd /opt/ && mvn clean package cargo:install
ENV PATH /opt:$PATH
CMD bash entrypoint.sh ${IASTIP} ${TOKEN} ${ProjectName}
