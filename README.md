### For one-click start of various range containers



openrasp    https://github.com/baidu/openrasp.git
```cmd
docker run -it --rm -e IASTIP="http://52.81" -e TOKEN="3d6bb430bc3" -e ProjectNam="openrasp"  8080:8080 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:openrasp-v1
```


webgoat    https://github.com/WebGoat/WebGoat.git
```cmd
docker run -it --rm -e IASTIP="http://52.81" -e TOKEN="3d6bb430bc3" -e ProjectName="webgoat" -p 8087:8087 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:webgoat-v1
```


benchmark    https://github.com/OWASP-Benchmark/BenchmarkJava.git
```cmd
docker run -it --rm -e IASTIP="http://52.81" -e TOKEN="3d6bb430bc3" -e ProjectName="webgoat" -p 8443:8443 registry.cn-hangzhou.aliyuncs.com/tscuite/bachang:benchmark-v1
```