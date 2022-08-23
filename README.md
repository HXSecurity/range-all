### For one-click start of various range containers


openrasp 8080/vulns/   https://github.com/baidu/openrasp.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="TOKEN" -e ProjectName="openrasp" registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:openrasp-v9
```

webgoat 8087/WebGoat/   https://github.com/WebGoat/WebGoat.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="TOKEN" -e ProjectName="webgoat" registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:webgoat-v9
```

benchmark 8443/benchmark/   https://github.com/OWASP-Benchmark/BenchmarkJava.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="TOKEN" -e ProjectName="benchmark" registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:benchmark-v9
```

iast-jar 8085/iast6\?name=hello  https://github.com/spring-projects/spring-boot.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="TOKEN" -e ProjectName="iast-jar" registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:iast-jar-v9
```

iast-grpc-java 8888 8083/grpc/send?text=1  https://github.com/HXSecurity/dongtai-grpc-range.git
```cmd
docker run -it --rm -e IASTIP="http://IP" -e TOKEN="TOKEN" -e ProjectName="iast-grpc-java" registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:iast-grpc-java-v9
```
