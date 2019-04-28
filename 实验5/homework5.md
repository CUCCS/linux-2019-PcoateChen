# 实验报告5
## 实验环境
- Ubuntu 18.04 Server 64bit

------------

## 实验内容

### 基本内容
- 在一台主机（虚拟机）上同时配置Nginx和VeryNginx
	- VeryNginx作为本次实验的Web App的反向代理服务器和WAF
	- PHP-FPM进程的反向代理配置在nginx服务器上，VeryNginx服务器不直接配置Web站点服务
- 使用Wordpress搭建的站点对外提供访问的地址为： https://wp.sec.cuc.edu.cn
- 使用Damn Vulnerable Web Application (DVWA)搭建的站点对外提供访问的地址为： http://dvwa.sec.cuc.edu.cn

### 安全加固内容
- 使用IP地址方式均无法访问上述任意站点，并向访客展示自定义的友好错误提示信息页面-1
- Damn Vulnerable Web Application (DVWA)只允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-2
- 在不升级Wordpress版本的情况下，通过定制VeryNginx的访问控制策略规则，热修复WordPress < 4.7.1 - Username Enumeration
- 通过配置VeryNginx的Filter规则实现对Damn Vulnerable Web Application (DVWA)的SQL注入实验在低安全等级条件下进行防护

### verynginx配置要求
- VeryNginx的Web管理页面仅允许白名单上的访客来源IP，其他来源的IP访问均向访客展示自定义的友好错误提示信息页面-3
- 通过定制VeryNginx的访问控制策略规则实现：
	- 限制DVWA站点的单IP访问速率为每秒请求数 < 50
	- 限制Wordpress站点的单IP访问速率为每秒请求数 < 20
	- 超过访问频率限制的请求直接返回自定义错误提示信息页面-4
	- 禁止curl访问

------------

## 实验过程
-  基本内容
	1. 安装nginx、verynginx、WordPress、DVWA
		- [ nginx](https://blog.csdn.net/fengfeng0328/article/details/82828224 " nginx")
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/n2.png?raw=true)
		- [verynginx](https://github.com/alexazhou/VeryNginx/blob/master/readme_zh.md "verynginx")
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/v.png?raw=true)
		- [WordPress](https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lemp-on-ubuntu-18-04#step-1-—-creating-a-mysql-database-and-user-for-wordpress "WordPress")
		- [DVWA](https://kifarunix.com/how-to-setup-damn-vulnerable-web-app-lab-on-ubuntu-18-04-server/ "DVWA")

	2. 设置配置文件和端口
		- [nginx](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/配置文件/default(nginx "nginx")
		- [verynginx](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/配置文件/nginx.conf(verynginx "verynginx")
		网页配置
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/vn.png?raw=true)
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/vn2.png?raw=true)
		设置主机host端口
		`192.168.56.101 wp.sec.cuc.edu.cn`
		`192.168.56.101 dvwa.sec.cuc.edu.cn`
	1. 实现效果
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/dvwa.png?raw=true)
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/wp.png?raw=true)
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/用例图.png?raw=true)
	
| 端口  |  服务器 |
| ------------ | ------------ |
|  80 |  nginx |
|  8088/85 |  verynginx |
| 8081 | Wordpress |
| 8082 | DVWA |

- 安全加固内容
	1. error -1
		- 添加matcher
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-1.png?raw=true)
		- 添加自定义response（error -1）
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-12.png?raw=true)
		- 添加filter
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-13.png?raw=true)
		- 结果
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-14.png?raw=true)
	1. error -2
		- 添加matcher
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-2.png?raw=true)
		- 添加自定义response（error -2）
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-21.png?raw=true)
		- 添加filter
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-23.png?raw=true)
		- 结果
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-24.png?raw=true)
	1. 热修复WordPress < 4.7.1 - Username Enumeration
		- 添加matcher
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/wp%3C4.1.7.png?raw=true)
		- 添加自定义response（WordPress < 4.7.1 - Username Enumeration）
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/wp%3C4.1.72.png?raw=true)
		- 添加filter
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/wp%3C4.1.73.png?raw=true)
		- 结果
		
	1. DVWA SQL注入实验在低安全等级
		- 添加matcher
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/d_s.png?raw=true)
		- 添加自定义response（）
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/d_s2.png?raw=true)
		- 添加filter
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/d_s3.png?raw=true)
		- 结果
		

- verynginx配置要求
	1. error -3
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-3.png?raw=true)
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-32.png?raw=true)
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-33.png?raw=true)
	1. 通过定制VeryNginx的访问控制策略规则实现：
	- 限制DVWA站点的单IP访问速率为每秒请求数 < 50
	- 限制Wordpress站点的单IP访问速率为每秒请求数 < 20
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/rate.png?raw=true)
	- 超过访问频率限制的请求直接返回自定义错误提示信息页面-4
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/-4.png?raw=true)
	- 禁止curl访问
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/curl.png?raw=true)
	![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework5/实验5/img/curl2.png?raw=true)

