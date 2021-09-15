# nginx

去[官方下载](http://nginx.org/en/download.html)最新稳定的版本,进行编译安装。安装之后，参考 `nginx/nginx.conf`进行配置. 之后进行重新加载

```
nginx -s reload
```

之后访问 `miner.your.domain` 就是你的grafana监控页面