#! /bin/bash
nohup bash runRemoteAccessibleBenchmark.sh &
echo "项目启动中...，请等待"
for i in {399..1}
do
sleep 1
a=`lsof -i:8443 | wc -l`
if [ "$a" -gt "0" ];then
    echo 靶场在倒计时进行到 $i 时提前启动了!!!
    break
else
    echo 靶场正在努力启动中: $i !!!
fi
done
echo "ok!!!"