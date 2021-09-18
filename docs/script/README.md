# 常用运维命令

当我们在运行机器的时候，平时可能要处理一些基本的逻辑。对于这快可能就属于一个体力活了，不过如果能把一些常用命令进行归档，那么下次使用的是就可以直接拿来用。如果这些命令都是建立在linux 命令的基础上，所以如果对这快不是很熟悉的，推荐翻阅[linuxcool](https://www.linuxcool.com/)进行处理.




### 常用命令

`查看系统当前网络连接数`

````
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
````

`按照 CPU/内存的使用情况列出前 10 的进程`

```shell
#内存
ps axo %mem,pid,euser,cmd | sort -nr | head -10
#CPU
ps -aeo pcpu,user,pid,cmd | sort -nr | head -10
```

`显示系统整体的 CPU 利用率和闲置率`

```shell
grep "cpu " /proc/stat | awk -F ' ' '{total = $2 + $3 + $4 + $5} END {print "idle \t used\n" $5*100/total "% " $2*100/total "%"}'
```

`快速杀死所有的 xx 进程`

```shell
ps aux | grep xx | awk '{ print $2 }' | xargs kill -9
```


`查找/目录下占用磁盘空间最大的top10文件`

```shell
find / -type f -print0 | xargs -0 du -h | sort -rh | head -n 10
```

`清空一个大文件`

```shell
mkdir empty && rsync -r --delete empty/ some-dir && rmdir some-dir
```

*tips*: 当一个文件很大的是，同时硬盘中没有其他资源，那么格式化是最快的方式

`列出硬盘`

```shell
lsblk  #列出块设备信息（df -h不能看到的卷）
```

#### 查看文件

`查看目录总大小`

```
du -sh
```


`查看目录下各个文件/目录大小`

```
ls -lh
```

## 资源文档
[the-art-of-command-line(新手)](https://github.com/jlevy/the-art-of-command-line/blob/master/README-zh.md)