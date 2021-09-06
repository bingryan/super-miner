# frp

[frp](https://github.com/fatedier/frp) 一种快速反向代理，可帮助你将 NAT 或防火墙后面的本地服务器暴露给公网.同时实操起来非常简单.


### server端

```shell
docker run --restart=always --network host -d -v /etc/frp/frps.ini:/etc/frp/frps.ini --name frps snowdreamtech/frps

```

### client 端

```shell
docker run --restart=always --network host -d -v /etc/frp/frpc.ini:/etc/frp/frpc.ini --name frpc snowdreamtech/frpc
```

对于client 端的配置

```shell
[common]
server_addr =公网地址
server_port = 8082
privilege_token = token

[remote_desk]
type = tcp
local_ip = 127.0.0.1
local_port = 9090
remote_port = 9981
```