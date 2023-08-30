# webgoat & dongtai 

# 一、编译

按照需求修改本地的文件，

```bash
docker build -t webgoat:v0.0.3 . 
```



启动项目： 

```bash
docker run -p 8087:8087 -it --rm -e IASTIP="https://poc.iast.huoxian.cn" -e TOKEN="xxxx"  -e ProjectName="xxxx"  webgoat:v0.0.3
```



自定义agent：

```bash
docker run -p 8087:8087 -it --rm -e IASTIP="https://poc.iast.huoxian.cn" -e TOKEN="xxxx"  -e ProjectName="xxxx" -v /opt/dongtai-java-agent/range-all/webgoat/agent:/opt/iast-agent webgoat:v0.0.3
```

把自己的agent放到/opt/dongtai-java-agent/range-all/webgoat/agent下，并命名为agent.jar。













