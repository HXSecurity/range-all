FROM quay.io/centos/centos:stream9
WORKDIR /opt
# 国外构建使用这个地址
ADD https://github.com/WebGoat/WebGoat/releases/download/v8.2.2/webgoat-server-8.2.2.jar .
# 国内构建使用这个地址
#ADD https://ghproxy.com/https://github.com/WebGoat/WebGoat/releases/download/v8.2.2/webgoat-server-8.2.2.jar .
COPY .webgoat-8.2.2  ~/
COPY . .
RUN yum -y install *epel* && yum install java-17-openjdk -y && yum -y install net-tools lsof jq --nogpgcheck && chmod +x ./entrypoint.sh
CMD bash entrypoint.sh ${IASTIP} ${TOKEN} ${ProjectName} ${OPTIONS}
