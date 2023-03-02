FROM quay.io/centos/centos:stream9
WORKDIR /opt
ADD https://github.com/WebGoat/WebGoat/releases/download/v8.2.2/webgoat-server-8.2.2.jar .
COPY .webgoat-8.2.2  ~/
COPY . .
RUN yum -y install *epel* && yum install java-17-openjdk -y \
    && yum -y install net-tools lsof jq --nogpgcheck && chmod +x ./entrypoint.sh
CMD bash entrypoint.sh ${IASTIP} ${TOKEN} ${ProjectName} ${OPTIONS}
