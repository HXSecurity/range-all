#bin/bash
chmod 777 openrasp-vuln-spider.sh
chmod 777 openrasp-vuln-check.sh
ports=$( netstat -nltp|grep 8080|awk '{ print $7}')
kill ${ports%/*}
read -p "请输入openrasp启动IP: 192.168.28.163:" IP
read -p "请输入数据库密码：" PASSWD
read -p "请输入iast地址，如：https://iast-test.huoxian.cn/：" IASTIP
read -p "请输入iast的token，如：3d6bb430bc3e0b20dcc2d4170991e1ece101744a：" TOKEN
read -p "请输入openrasp在iast的项目名称：" ProjectNam
if [ -z "$IP" ];
then
	IP="localhost"
fi

if [ -z "$PASSWD" ];
then
	PASSWD="classbro???"
fi

if [ -z "$IASTIP" ];
then
	IASTIP="http://52.81.57.209:8001"
fi

if [ -z "$TOKEN" ];
then
	TOKEN="d64af83496272a88c64f97a3dd82e691f2b42252"
fi

if [ -z "$ProjectNam" ];
then
	ProjectNam="openrasp"
fi

mysql -uroot -p$PASSWD -h$IP -e "DROP DATABASE IF EXISTS test;"
mysql -uroot -p$PASSWD -h$IP -e "CREATE DATABASE test;"
mysql -uroot -p$PASSWD -h$IP -e "CREATE USER 'test' IDENTIFIED BY 'test';"
mysql -uroot -p$PASSWD -h$IP -e "GRANT ALL ON *.* TO 'test'@'%';"
mysql -uroot -p$PASSWD -h$IP -e "CREATE TABLE test.vuln (id INT, name text);"
mysql -uroot -p$PASSWD -h$IP -e "INSERT INTO test.vuln values (0, 'openrasp');"
mysql -uroot -p$PASSWD -h$IP -e "INSERT INTO test.vuln values (1, 'rocks');"
mysql -uroot -p$PASSWD -h$IP -e "DROP DATABASE IF EXISTS testdb;"
mysql -uroot -p$PASSWD -h$IP -e "CREATE DATABASE testdb;"
mysql -uroot -p$PASSWD -h$IP -e "CREATE user 'testuser'@'%' identified with mysql_native_password by 'testpassword';"
mysql -uroot -p$PASSWD -h$IP -e "GRANT ALL ON *.* TO 'testuser'@'%';"
mysql -uroot -p$PASSWD -h$IP -e "CREATE TABLE testdb.vuln (id INT, name text);"
mysql -uroot -p$PASSWD -h$IP -e "INSERT INTO testdb.vuln values (0, 'openrasp');"
mysql -uroot -p$PASSWD -h$IP -e "INSERT INTO testdb.vuln values (1, 'rocks');"
#tar -xvf tomcat8.tar.gz
cd tomcat8/bin/
curl -X GET "$IASTIP/openapi/api/v1/agent/download?url=$IASTIP/openapi&language=java" -H "Authorization: Token $TOKEN" -o agent.jar -k
sed "2c CATALINA_OPTS=\"-javaagent:agent.jar -Dproject.name=$ProjectNam\"" catalina.sh >catalina_old.sh
#sed "2c CATALINA_OPTS=\"-javaagent:agent.jar -Ddongtai.log.address=52.81.92.214 -Ddongtai.log.port=31919 -Ddongtai.log.level=debug -Ddongtai.log=true -Dproject.name=$ProjectNam\"" catalina.sh >catalina_old.sh
rm -rf catalina.sh
mv catalina_old.sh catalina.sh
chmod 777 catalina.sh
nohup ./startup.sh &
echo "项目启动中...请等待1分钟"
sleep 1m
cd ../../
HOST="http://"$IP":8081"
echo "开始触发靶场流量"
./openrasp-vuln-spider.sh $HOST
echo "请等待1分钟"
sleep 1m
echo "开始漏洞检测"
./openrasp-vuln-check.sh $ProjectNam $IASTIP $TOKEN
