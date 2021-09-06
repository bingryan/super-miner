# 限制

当机器进行多挖的时候，如果不对某个应用进行资源限定，那么一个应用占用太多资源，会倒是其他应用出现资源不够

### 网络限制速度

wondershaper [接口] [上传速度 K] [下载速度 K] 接口指网络连接的接口, 也就是与调制解调器连接 (从而和因特网连接) 的网卡. 查找命令用的是 ifconfig

```
sudo apt-get install wondershaper

```

```
sudo wondershaper enp2s0 10240 10240  （限制enp2s0网卡下载速度10240K，上传速度10240K）

sudo wondershaper clear enp2s0 (清除网络限制)
```


### 限制CPU使用


```shell
sudo apt-get install cpulimit

# PID=1111 的 CPU 上限 50%
cpulimit --pid 1111 --limit 50
# 后台运行
cpulimit --pid 1111 --limit 50 --background
# 清理限制
cpulimit --pid 1111 --limit 50 --kill


```

```shell
#!/usr/bin/env bash

set -e

echo "*** 开始限制CPU ***"


# shellcheck disable=SC2034
sworker_pid=$(pidof crust-sworker)



sudo cpulimit --pid $sworker_pid --limit 60 --background


crust_pid=$(pidof crust)

sudo cpulimit --pid $crust_pid --limit 50 --background
```

比如[crust limit_cpu 生产下脚本](https://github.com/bingryan/super-miner/blob/main/bin/limit_cpu.sh)