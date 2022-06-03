#! /bin/bash
IP="0.0.0.0"
PORT="8087"
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}
tar -xvf openjdk-16_linux-x64_bin.tar.gz
cd jdk-16/bin
curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
nohup ./java -javaagent:agent.jar -Ddongtai.app.name=${ProjectNam} -Ddongtai.log.level=debug -Ddongtai.log=true -Ddongtai.app.version=2.1  -jar ../../webgoat-server-8.2.2.jar --server.address=$IP --server.port=$PORT &
echo "项目启动中...，请等待1分钟"
sleep 1m
cd ../../
HOST="http://"$IP":"$PORT
curl -H 'Content-type: application/x-www-form-urlencoded'  -X POST -d 'username=usertest&password=123456&matchingPassword=123456&agree=agree' ${HOST}/WebGoat/register.mvc 
echo "开始触发靶场流量"
./webgoat.sh $HOST
echo "请等待1分钟"
sleep 1m
echo "开始漏洞检测"
./webgoat-check.sh $ProjectNam $IASTIP $TOKEN
tail -f /dev/null