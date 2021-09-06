# docker 常用命令

## 关闭

### 1、关闭以--restart=always启动的容器

```
docker update --restart=no <container-id>
docker stop <container-id>
```


## 删除

### 1、查询并删除所有容器

```shell
docker stop $(docker ps -q) & docker rm $(docker ps -aq)
# sudo 权限
sudo docker stop $(sudo docker ps -q) & sudo docker rm $(sudo docker ps -aq)
```

### 2、查询并删除所有images

```shell
# docker rmi `docker images -q`
# docker rmi $(docker images -q)
#  docker rmi $(docker images -q) -f
```

### 3、删除所有已停止的容器


```
docker rm $(docker ps -a -q)
```

### 4、删除意见退出的容器

```
docker rm $(docker ps -q -f status=exited)
```

### 5、正则删除

```
sudo docker ps -a | grep 包含名字 | awk '{print $1}'  | xargs sudo docker rm -f
```

比如删除包含`registrator`

```
sudo docker ps -a | grep registrator | awk '{print $1}'  | xargs sudo docker rm -f
```


## 设置

### 更改存储路径和源


下面是硬盘挂载了 `/opt`目录下，所以设置把数据存储在 `/opt/docker`，

`/etc/docker/daemon.json`

```bash
{
  "registry-mirrors" : [
    "http://ovfftd6p.mirror.aliyuncs.com",
    "http://registry.docker-cn.com",
    "http://docker.mirrors.ustc.edu.cn",
    "http://hub-mirror.c.163.com"
  ],
  "insecure-registries" : [
    "registry.docker-cn.com",
    "docker.mirrors.ustc.edu.cn"
  ],
  "graph": "/opt/docker",
  "debug" : true,
  "experimental" : true
}

```


## 可使用资源

[docker command](https://docs.docker.com/engine/reference/commandline/docker/)