# ansible

ansible 是一个自动化工具，具体可以查看官方文档[ansible 官方文档](https://docs.ansible.com/ansible/latest/cli/ansible-doc.html)

## 安装


```shell
sudo apt install ansible
```



## 全局配置
`/etc/ansible/ansible.cfg` 或者 `~/.ansible.cfg` :

```shell
[defaults]
host_key_checking = False
```

## inventory 配置

`/etc/ansible/hosts`

```shell
mail.example.com

[webservers]
foo.example.com
bar.example.com

[dbservers]
one.example.com
two.example.com
three.example.com
```
然后可以ping

```shell
ansible all -m ping
ansible dbservers -m ping
```




## 资源

[ansible-cn](https://ansible-tran.readthedocs.io/en/latest)

[ansible user guide](https://docs.ansible.com/ansible/latest/user_guide/)
