# 母盘制作


## 系统
### 安装依赖

```
sudo bin/install.sh
```


### 设置ssh免密码

```bash
ssh-keygen -t rsa
```

```shell
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

### 设置用户免密码

root 下进行
`chmod u+w /etc/sudoers`
```
找到root用户

root    ALL=(ALL)       ALL

在root用户下面添加以下内容

abc   ALL=(ALL)      ALL

或

abc   ALL=(ALL)      NOPASSWD:ALL

```

第一种在sudo的时候需要输入密码

第二种在sudo的时候不需要输入密码,

推荐设置：
```shell
# User privilege specification
root	ALL=(ALL:ALL) ALL
abc   ALL=(ALL)  NOPASSWD:ALL

# Members of the admin group may gain root privileges
%admin ALL=(ALL) NOPASSWD:ALL

# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) NOPASSWD:ALL
```


`chmod u-w /etc/sudoers`

### Ubuntu 设置开机自启动


`方案一`

1、在/etc/systemd/system目录下创建rc.local.service服务的软链接。

```shell
ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/
systemctl enable rc-local.service
```
针对 registrator.sh,需要开机自动起
```shell
sudo chmod 755 registrator.sh
sudo cp registrator.sh /etc/init.d/
sudo update-rc.d registrator.sh defaults 100
```
如果要移除，执行
```shell
sudo update-rc.d -f registrator.sh remove
```

`方案二`

1、检查系统目录/lib/systemd/system/rc-local.service,如果没有自己创建


内容如下，如果没有Install 加上

```shell
vim /etc/systemd/system/rc-local.service
```

```shell
#  SPDX-License-Identifier: LGPL-2.1+
#
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.

# This unit gets pulled automatically into multi-user.target by
# systemd-rc-local-generator if /etc/rc.local is executable.
[Unit]
Description=/etc/rc.local Compatibility
Documentation=man:systemd-rc-local-generator(8)
ConditionFileIsExecutable=/etc/rc.local
After=network.target

[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
RemainAfterExit=yes
GuessMainPID=no

[Install]
WantedBy=multi-user.target
Alias=rc-local.service
```

制定
```
systemctl enable rc-local.service
```

2、增加如下内容

```shell
chmod +x /etc/rc.local
vim /etc/rc.local
```

下面设置为 `/usr/local/bin/start_miner` 为自启动脚本

如下:
```shell
#!/bin/bash
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
sudo /usr/local/bin/start_miner &

exit 0
```

```shell
systemctl start rc-local  开启服务
systemctl stop rc-local   关闭服务
systemctl restart rc-local    重启服务
systemctl status rc-local    查看服务状态
systemctl enable rc-local    将服务设置为开机自启动
systemctl disable rc-local    禁止服务开机自启动
systemctl is-enabled rc-local    查看服务是否开机启动
systemctl list-unit-files|grep enabled    查看开机启动的服务列表
systemctl --failed    查看启动失败的服务列表
```


