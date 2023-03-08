FROM quay.io/centos/centos:stream9
WORKDIR /opt
RUN yum -y install *epel* &&  yum -y install libpcap-devel \
  && ls -al /usr/lib64/libpcap.so.* \
  && ALIMARCH=`arch` && curl -L https://charts.dongtai.io/apk/${ALIMARCH}/xray -o /usr/bin/xray \
  && ln -s /usr/lib64/libpcap.so.1.10.0 /usr/lib64/libpcap.so.0.8 && chmod +x /usr/bin/xray
COPY . .
ENTRYPOINT xray ${XRAY_SHELL}