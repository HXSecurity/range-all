#! /bin/bash
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}
curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
sed -i "s#${basedir}/tools/Contrast/contrast.jar#-javaagent:/owasp/BenchmarkJava/agent.jar#g" pom.xml
sed -i "s#-Dcontrast.dir=${basedir}/tools/Contrast/working#-Ddongtai.app.name=${ProjectNam}#g" pom.xml
sed -i "s#-Dcontrast.config.path=${basedir}/tools/Contrast/contrast.yaml#-Ddongtai.log.level=debug#g" pom.xml
nohup bash runRemoteAccessibleBenchmark.sh &
echo "项目启动中...，请等待1分钟"
sleep 3m
bash runCrawler.sh
echo "ok!!!"
tail -f /dev/null