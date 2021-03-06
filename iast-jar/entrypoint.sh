#! /bin/bash
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}
mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
mysqld --daemonize --user=mysql
sleep 5s
mysql -uroot -e "CREATE DATABASE test;"
mysql -uroot -e "CREATE USER 'test' IDENTIFIED BY 'test';"
mysql -uroot -e "GRANT ALL ON *.* TO 'test'@'%';"
mysql -uroot -e "CREATE TABLE test.users (id INT, username VARCHAR(255),password VARCHAR(255));"
mysql -uroot -e "INSERT INTO test.users VALUES (1, 'admin', 'admin123');"
mysql -uroot -e "INSERT INTO test.users VALUES (2, 'test', 'test123');"

curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
if [ ! -f "agent.jar" ]; then
echo "Please check your address and token ! ! !"
exit 1
fi
if [ `ls -s agent.jar |awk '{print $1}'` -lt 10240 ];then
echo "Please check your address and token ! ! !"
exit 1
fi
nohup java -javaagent:agent.jar -Ddongtai.app.name=${ProjectNam} -Ddongtai.log.level=debug  -Ddongtai.app.version=2.1  -cp spring-core-rce-0.0.1-SNAPSHOT-jar-with-dependencies.jar -jar spring-core-rce-0.0.1-SNAPSHOT.jar &

echo "项目启动中...，请等待"
for i in {399..1}
do
sleep 1

a=`lsof -i:8085 | wc -l`
if [ "$a" -gt "0" ];then
    echo 靶场在倒计时进行到 $i 时提前启动了!!!
    break
else
    echo 靶场正在努力启动中: $i !!!
fi
done
curl 127.0.0.1:8085/iast6\?name=hello
tail -f /dev/null
