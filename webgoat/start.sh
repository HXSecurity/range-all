#!/bin/bash
chmod 777 webgoat-check.sh
chmod 777 webgoat.sh
ports=$( netstat -nltp|grep 8087|awk '{ print $7}')
kill ${ports%/*}
read -p "请输入webgoat启动IP: 192.168.28.163:" IP
read -p "请输入webgoat启动端口 : 8080:" PORT
read -p "请输入iast地址，如：https://iast-test.huoxian.cn/：" IASTIP
read -p "请输入iast的token，如：3d6bb430bc3e0b20dcc2d4170991e1ece101744a：" TOKEN
read -p "请输入webgoat在iast的项目名称：" ProjectNam
if [ -z "$IP" ];
then
	IP="0.0.0.0"
fi

if [ -z "$PORT" ];
then
	PORT=8087
fi

if [ -z "$IASTIP" ];
then
	IASTIP="https://pre.iast.huoxian.cn"
fi

if [ -z "$TOKEN" ];
then
	TOKEN="df86d3d9bac8459a46d31a5a9ad5c8681cb9bc29"
fi

if [ -z "$ProjectNam" ];
then
	ProjectNam="2linlin-webgoat2"
fi

tar -xvf openjdk-16_linux-x64_bin.tar.gz
cd jdk-16/bin
curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k

#nohup ./java -jar ../../webgoat-server-8.2.2.jar --server.address=$IP --server.port=$PORT &

nohup ./java -javaagent:agent.jar -Ddongtai.app.name=$ProjectNam -Ddongtai.log.level=debug -Ddongtai.log=true -Ddongtai.app.version=2.1  -jar ../../webgoat-server-8.2.2.jar --server.address=$IP --server.port=$PORT &

echo "项目启动中...，请等待1分钟"
sleep 1m
cd ../../
HOST="http://"$IP":"$PORT
echo "开始触发靶场流量"
./webgoat.sh $HOST 
echo "请等待1分钟"
sleep 1m
echo "开始漏洞检测"
./webgoat-check.sh $ProjectNam $IASTIP $TOKEN
