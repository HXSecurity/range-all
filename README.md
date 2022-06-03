### For one-click start of various range containers



openrasp    https://github.com/baidu/openrasp.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="3d6bb430bc3" -e ProjectName="openrasp" -p 8080:8080 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:openrasp-v1
```


webgoat    https://github.com/WebGoat/WebGoat.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="3d6bb430bc3" -e ProjectName="webgoat" -p 8087:8087 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:webgoat-v1
```


benchmark    https://github.com/OWASP-Benchmark/BenchmarkJava.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="3d6bb430bc3" -e ProjectName="benchmark" -p 8443:8443 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:benchmark-v1
```


iast-jar    https://github.com/spring-projects/spring-boot.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="3d6bb430bc3" -e ProjectName="iast-jar" -p 8085:8085 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:iast-jar-v1
```


iast-grpc-java    https://github.com/HXSecurity/dongtai-grpc-range.git

```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="3d6bb430bc3" -e ProjectName="iast-grpc-java" -p 8888:8888 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:iast-grpc-java-v1
```