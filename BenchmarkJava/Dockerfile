# This dockerfile builds a container that pulls down and runs the latest version of Benchmark
FROM centos:7
WORKDIR /opt
COPY . .
RUN yum -y install yum -y install *epel* \
    && yum -y install jq git unzip tzdata maven java-1.8.0-openjdk* --nogpgcheck && chmod +x ./entrypoint.sh

RUN unzip git.zip && git clone https://github.com/OWASP-Benchmark/BenchmarkUtils.git && cd BenchmarkUtils && mvn install
RUN cd /opt/ && mvn clean package cargo:install
ENV PATH /opt:$PATH
CMD bash entrypoint.sh ${IASTIP} ${TOKEN} ${ProjectName}
