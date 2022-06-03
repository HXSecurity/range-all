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
mysql -uroot -e "CREATE TABLE test.vuln (id INT, name text);"
mysql -uroot -e "INSERT INTO test.vuln values (0, 'openrasp');"
mysql -uroot -e "INSERT INTO test.vuln values (1, 'rocks');"
mysql -uroot -e "CREATE DATABASE testdb;"
mysql -uroot -e "CREATE user 'testuser'@'%' identified with mysql_native_password by 'testpassword';"
mysql -uroot -e "GRANT ALL ON *.* TO 'testuser'@'%';"
mysql -uroot -e "CREATE TABLE IF NOT EXISTS test.users (`id` INT UNSIGNED AUTO_INCREMENT,`username` VARCHAR(255) NOT NULL,`password` VARCHAR(255) NOT NULL, PRIMARY KEY (`id`))ENGINE=InnoDB DEFAULT CHARSET=utf8;"
mysql -uroot -e "INSERT INTO test.users VALUES (1, 'admin', 'admin123');"
mysql -uroot -e "INSERT INTO test.users VALUES (2, 'test', 'test123');"

curl -X GET $IASTIP'/openapi/api/v1/agent/download?url='$IASTIP'/openapi&language=java' -H 'Authorization: Token '$TOKEN -o agent.jar -k
nohup java -javaagent:agent.jar -Ddongtai.app.name=${ProjectNam} -Ddongtai.log.level=debug  -Ddongtai.app.version=2.1  -jar spring-core-rce-0.0.1-SNAPSHOT-jar-with-dependencies.jar &
echo "项目启动中...，请等待1分钟,8085"
sleep 1m
tail -f /dev/null
