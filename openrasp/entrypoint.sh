#! /bin/bash
IP="localhost"
IASTIP=${1}
TOKEN=${2}
ProjectNam=${3}

mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
mysqld --daemonize --user=mysql
sleep 5s
mysql -uroot -e "CREATE DATABASE test;"
mysql -uroot -e "CREATE USER 'test' IDENTIFIED BY 'test';"
mysql -uroot -e "GRANT ALL ON *.* TO 'test'@'%';"
mysql -uroot -e "CREATE TABLE test.vuln (id INT, name text);"
mysql -uroot -e "INSERT INTO test.vuln values (0, 'openrasp');"
mysql -uroot -e "INSERT INTO test.vuln values (1, 'rocks');"
mysql -uroot -e "CREATE DATABASE testdb;"
mysql -uroot -e "CREATE user 'testuser'@'%' identified with mysql_native_password by 'testpassword';"
mysql -uroot -e "GRANT ALL ON *.* TO 'testuser'@'%';"
mysql -uroot -e "CREATE TABLE testdb.vuln (id INT, name text);"
mysql -uroot -e "INSERT INTO testdb.vuln values (0, 'openrasp');"
mysql -uroot -e "INSERT INTO testdb.vuln values (1, 'rocks');"
tar -xvf tomcat8.tar.gz
cd tomcat8/bin/
curl -X GET "$IASTIP/openapi/api/v1/agent/download?url=$IASTIP/openapi&language=java" -H "Authorization: Token $TOKEN" -o agent.jar -k
sed "2c CATALINA_OPTS=\"-javaagent:agent.jar -Ddongtai.log.level=debug -Ddongtai.log=true -Dproject.name=$ProjectNam\"" catalina.sh >catalina_old.sh
rm -rf catalina.sh
mv catalina_old.sh catalina.sh
chmod 777 catalina.sh
nohup ./startup.sh &
echo "项目启动中...请等待1分钟"
sleep 1m
cd ../../
HOST="http://"$IP":8080"
echo "开始触发靶场流量"
./openrasp-vuln-spider.sh $HOST
echo "请等待1分钟"
sleep 1m
echo "开始漏洞检测"
./openrasp-vuln-check.sh $ProjectNam $IASTIP $TOKEN
tail -f /dev/null
