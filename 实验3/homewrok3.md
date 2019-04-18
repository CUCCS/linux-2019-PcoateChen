# 实验报告3
## 实验环境
- Ubuntu 16.04 Server 64bit

------------

## 实验内容
- 动手实战Systemd
- 自查清单

------------

## 实验过程
- systemd录屏
	1. [systemd](https://asciinema.org/a/wc1ttX4qsnXURzfugw2DwsRl9 "systemd")
	1. [unit](https://asciinema.org/a/SHBv7qrTNKcmRBCruGrQqDCCK "unit")
	1. [target&log](https://asciinema.org/a/5dESo11OXmHKmV4fsfDoq4sxv "target&log")
- 自查清单
	1. 如何添加一个用户并使其具备sudo执行程序的权限？
		- 创建新账户`sudo adduser username`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/1.png?raw=true)
		- 将用户添加到sudo组`usermod -aG groupname username`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/2.png?raw=true)
	1. 如何将一个用户添加到一个用户组？
		`usermod -aG groupname username`
	1. 如何查看当前系统的分区表和文件系统详细信息？
		- `sudo fdisk -l`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/3.1.png?raw=true)
		- `df -a`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/3.2.png?raw=true)
	1. 如何实现开机自动挂载Virtualbox的共享目录分区？
	
	1. 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
		- 减容 `sudo lvreduce --size SIZE /dev/cuc-vg/root`
		- 扩容 `sudo lvextend --size SIZE /dev/cuc-vg/root`
	1. 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？
		可以在每次开启关闭网络的时候执行shell脚本  `scritps.sh`
		`/etc/network/interfaces` 文件为网络配置文件
		``
		``
		` pre-up ,up,down,post-down`为网卡启动的钩子
		`pre-up`  对应的为 网络启动之前执行脚本
		`up `        对应网络启动之后执行脚本
		`down`    网络关闭之间
		`post-down`  网络关闭之后
	1. 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？
		编辑配置文件 `Restart=always`
# 实验报告3
## 实验环境
- Ubuntu 16.04 Server 64bit

------------

## 实验内容
- 动手实战Systemd
- 自查清单

------------

## 实验过程
- systemd录屏
	1. [systemd](https://asciinema.org/a/wc1ttX4qsnXURzfugw2DwsRl9 "systemd")
	1. [unit](https://asciinema.org/a/SHBv7qrTNKcmRBCruGrQqDCCK "unit")
	1. [target&log](https://asciinema.org/a/5dESo11OXmHKmV4fsfDoq4sxv "target&log")
- 自查清单
	1. 如何添加一个用户并使其具备sudo执行程序的权限？
		- 创建新账户`sudo adduser username`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/1.png?raw=true)
		- 将用户添加到sudo组`usermod -aG groupname username`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/2.png?raw=true)
	1. 如何将一个用户添加到一个用户组？
		`usermod -aG groupname username`
	1. 如何查看当前系统的分区表和文件系统详细信息？
		- `sudo fdisk -l`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/3.1.png?raw=true)
		- `df -a`
		
		![](https://github.com/CUCCS/linux-2019-PcoateChen/blob/homework3/实验3/img/3.2.png?raw=true)
	1. 如何实现开机自动挂载Virtualbox的共享目录分区？
	
	1. 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？
		- 减容 `sudo lvreduce --size SIZE /dev/cuc-vg/root`
		- 扩容 `sudo lvextend --size SIZE /dev/cuc-vg/root`
	1. 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？
		可以在每次开启关闭网络的时候执行shell脚本  `scritps.sh`
		`/etc/network/interfaces` 文件为网络配置文件
		` pre-up ,up,down,post-down`为网卡启动的钩子
		`pre-up`  对应的为 网络启动之前执行脚本
		`up `        对应网络启动之后执行脚本
		`down`    网络关闭之间
		`post-down`  网络关闭之后
	1. 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？
		编辑配置文件 `Restart=always`
		` [Unit]`
		`Description=foo`
		`[Service]`
		`ExecStart=/bin/bash -c "while true; do /usr/bin/inotifywait -qq --`
		`event modify /tmp/foo; cp /tmp/foo /tmp/bar; done"`
		`Restart=always`
		` [Install]`
		`WantedBy=multi-user.target`
------------


