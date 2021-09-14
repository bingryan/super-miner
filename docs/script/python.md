# Python

python 在处理一些问题的时候也是比shell 更加方便

## 批量生产IP段

ansible hosts 填入一批机器
```
for i in range(115, 145):
	print("192.168.4.{}".format(i))
```