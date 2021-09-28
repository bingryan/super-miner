# ansible案例

## 查看所有机器是否可以链接外网

```
ansible myservers  -a "timeout 2 ping www.baidu.com" -m shell
```