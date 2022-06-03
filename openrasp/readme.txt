操作步骤：
	1.执行start.sh文件
	2.提示：请输入openrasp启动IP: 192.168.28.163:
		输入MySQL数据库所在IP
	3.提示：请输入数据库密码：
		输入MySQL数据库密码
	4.提示：请输入iast地址，如：https://iast-test.huoxian.cn/：
		输入iast地址,http://52.81.92.214:30158/
	5.提示：请输入iast的token，如：3d6bb430bc3e0b20dcc2d4170991e1ece101744a：
		输入iast的token，3d6bb430bc3e0b20dcc2d4170991e1ece101744a
	6.提示：请输入openrasp在iast的项目名称：
		输入openrasp在iast中的项目名称

测试结果：
未检测出的漏洞：api存在漏洞，但iast未检测出漏洞，输入漏报漏洞信息
无漏洞api：api未检测出漏洞
提示信息：iast检测出api存在提示信息