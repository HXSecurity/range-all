#! /bin/bash
IP="0.0.0.0"
PORT="8087"
IASTIP=${1}
TOKEN=${2}
ProjectName=${3}
if [ ! -n "${4}" ]; then
  echo "IS NULL"
  dongtai_log="-Ddongtai.log.level=debug"
else
  echo "NOT NULL"
fi

# ----------------------------------------------- 下载洞态的agent.jar文件 ------------------------------------------------

agent_path="./iast-agent/agent.jar"
if [ ! -f "$agent_path" ]; then
  mkdir ./iast-agent/
  echo "Start downloading the agent.jar file from the server $IASTIP"
  curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o $agent_path -k
else
  echo "Use locally found $agent_path files"
fi
if [ ! -f "$agent_path" ]; then
  echo "Please check your address and token ! ! !"
  exit 1
fi
if [ $(ls -s $agent_path | awk '{print $1}') -lt 10240 ]; then
  echo "Please check your address and token ! ! !"
  exit 1
fi

# ----------------------------------------------- 启动应用 --------------------------------------------------------------

nohup java -javaagent:$agent_path -Ddongtai.app.name=${ProjectName} ${dongtai_log} -Ddongtai.log=true -Ddongtai.app.version=2.1 -Diast.server.url=$IASTIP \
  --add-opens="java.xml/com.sun.xml.internal.stream=ALL-UNNAMED" \
  --add-opens="java.xml/com.sun.org.apache.xerces.internal.utils=ALL-UNNAMED" \
  --add-opens="java.xml/com.sun.org.apache.xerces.internal.impl=ALL-UNNAMED" \
  --add-opens="java.base/sun.net.www=ALL-UNNAMED" \
  --add-opens="java.base/sun.net.www.protocol.http=ALL-UNNAMED" \
  ${4} \
  -jar webgoat-server-8.2.2.jar --server.address=$IP --server.port=$PORT &
echo "项目启动中...，请等待"
for i in {399..1}; do
  sleep 1

  a=$(lsof -i:8087 | wc -l)
  if [ "$a" -gt "0" ]; then
    echo 靶场在倒计时进行到 $i 时提前启动了!!!
    break
  else
    echo 靶场正在努力启动中: $i !!!
  fi
done

HOST="http://"$IP":"$PORT
curl -H 'Content-type: application/x-www-form-urlencoded' -X POST -d 'username=usertest&password=123456&matchingPassword=123456&agree=agree' ${HOST}/WebGoat/register.mvc
echo "开始触发靶场流量"
./webgoat.sh $HOST
echo "流量触发结束ok!!!"

#sleep 1m
#echo "开始漏洞检测"
#./webgoat-check.sh ProjectName $IASTIP $TOKEN

for i in {60..1}; do
  sleep 1
  echo "Agent的漏洞数据可能未上传完毕，请等待... $i"
done
echo ""

tail -f /dev/null
