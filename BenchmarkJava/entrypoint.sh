#! /bin/bash
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}
curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
nohup bash runRemoteAccessibleBenchmark.sh &
echo "项目启动中...，请等待3分钟"
for i in {180..1}
do
sleep 1
echo shell炸弹爆炸倒计时: $i !!!
done
dddpid=$(netstat -anp|grep 8443|awk '{printf $7}'|cut -d/ -f1)
java -jar agent.jar -m install --app_version "v1.0.1" --app_name "${ProjectNam}" --app_create "true"  -p ${dddpid}
bash runCrawler.sh
echo "ok!!!"
tail -f /dev/null