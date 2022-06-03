### 用于一键启动各种靶场容器

openrasp
```cmd
docker run -it --rm -e IASTIP="http://52.81" -e TOKEN="3d6bb430bc3" -e ProjectNam="openrasp"  8080:8080 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:openrasp-v1
```

webgoat
```cmd
docker run -it --rm -e IASTIP="http://52.81" -e TOKEN="3d6bb430bc3" -e ProjectName="webgoat" -p 8089:8087 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:webgoat-v1
```
