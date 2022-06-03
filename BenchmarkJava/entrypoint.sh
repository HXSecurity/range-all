#! /bin/bash
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}
curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
sed -i "s/sdafsdafsdafdsafadsfsfd/${ProjectNam}/g" pom.xml
nohup bash runBenchmark.sh &
echo "项目启动中...，请等待1分钟"
sleep 1m
bash runCrawler.sh
echo "ok!!!"
tail -f /dev/null