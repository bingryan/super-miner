# 使用ansible批量管理远程服务器

## 常用模块

#### copy模块

```shell

ansible myservers -m copy -a "src=/opt/ dest=/opt mode=0755"
ansible [组] -m copy -a "src=本地 dest=目的地 mode=0755"
```

#### command模块(不支持管道)

command模块为ansible默认模块，不指定-m参数时，使用的就是command模块；

```shell
ansible myservers  -a 'pwd'
```

#### shell模块(支持管道)

使用shell模块，在远程命令通过/bin/sh来执行

```shell
ansible myservers  -a "ps aux" -m shell
```



#### scripts模块

使用scripts模块可以在本地写一个脚本,对于几十行的代码以上逻辑是非常有用的，在远程服务器上执行：

```shell
ansible myservers  -m script -a "/opt/my_local.sh"
```


## 可用资源

#### 批量执行playbooks

[ansible-examples](https://github.com/ansible/ansible-examples)
