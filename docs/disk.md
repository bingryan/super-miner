# 硬盘


## 多个硬盘合并实操

### 0.前提依赖

```shell
sudo apt install lvm2
```

### 1.创建pv

`查看挂载硬盘`

```
lsblk
```



```shell
sudo pvcreate /dev/sdb //硬盘1
sudo pvcreate /dev/sdc //硬盘2
sudo pvcreate /dev/sdd //硬盘3
sudo pvcreate /dev/sdf //硬盘4
sudo pvcreate /dev/sde //硬盘5
```
记录如下：

```shell
abc@abc:~$ pvcreate /dev/sdb
  WARNING: Running as a non-root user. Functionality may be unavailable.
  /run/lock/lvm/P_global:aux: open failed: Permission denied
abc@abc:~$ sudo pvcreate /dev/sdb
[sudo] password for abc:
  Physical volume "/dev/sdb" successfully created.
abc@abc:~$ sudo pvcreate /dev/sdc
WARNING: dos signature detected on /dev/sdc at offset 510. Wipe it? [y/n]: y
  Wiping dos signature on /dev/sdc.
  Physical volume "/dev/sdc" successfully created.
abc@abc:~$ sudo pvcreate /dev/sdd
WARNING: dos signature detected on /dev/sdd at offset 510. Wipe it? [y/n]: y
  Wiping dos signature on /dev/sdd.
  Physical volume "/dev/sdd" successfully created.
abc@abc:~$ sudo pvcreate /dev/sde
WARNING: dos signature detected on /dev/sde at offset 510. Wipe it? [y/n]: y
  Wiping dos signature on /dev/sde.
  Physical volume "/dev/sde" successfully created.
abc@abc:~$ sudo pvcreate /dev/sdf
WARNING: dos signature detected on /dev/sdf at offset 510. Wipe it? [y/n]: y
  Wiping dos signature on /dev/sdf.
  Physical volume "/dev/sdf" successfully created.
```
报错
1.1 Device /dev/sde excluded by a filter
```shell
abc@abc:~$ sudo parted /dev/sde
GNU Parted 3.3
Using /dev/sde
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) mklabel msdos
Warning: Partition(s) on /dev/sde are being used.
Ignore/Cancel? Ignore
Warning: The existing disk label on /dev/sde will be destroyed and all data on this disk will be lost. Do you want to continue?
Yes/No? Yes
Error: Partition(s) 1 on /dev/sde have been written, but we have been unable to inform the kernel of the change, probably because it/they are in use.  As a result, the old partition(s) will remain in use.
You should reboot now before making further changes.
Ignore/Cancel? Ignore
(parted) quit
Information: You may need to update /etc/fstab.
```

### 2.查看物理卷

```shell
pvs  # pvdisplay 可以更详细
```
记录

```shell
abc@abc:~$ sudo pvs
  PV         VG Fmt  Attr PSize  PFree
  /dev/sdb      lvm2 ---  <3.64t <3.64t
  /dev/sdc      lvm2 ---  <3.64t <3.64t
  /dev/sdd      lvm2 ---  <3.64t <3.64t
  /dev/sde      lvm2 ---  <3.64t <3.64t
  /dev/sdf      lvm2 ---  <3.64t <3.64t
```

### 3.创建卷组（VG）

```shell
//vgcreate [自定义LVM名称] [设备]
//先使用硬盘1创建vg:LVM
sudo vgcreate LVM /dev/sdb
```

### 4.扩展卷组（VG）

```shell
//vgextend [自定义vg名称] [设备]
//使用硬盘2扩展vg
sudo vgextend LVM /dev/sdc
sudo vgextend LVM /dev/sdd
sudo vgextend LVM /dev/sde
sudo vgextend LVM /dev/sdf
```

#### 5.创建lv

```shell
//lvcreate -L [自定义分区大小] -n [自定义分区名称] [vg名称]
//*分区大小不能超过硬盘容量总和*
sudo lvcreate -L 5.0T -n DB LVM


// 或者采用百分百方式进行
sudo lvcreate -l 100%VG -n DB_DATA LVM
```

### 6.格式化分区

```shell
sudo mkfs.ext4 /dev/LVM/DB_DATA
```

### 7.设置开机自动挂载

vim /etc/fstab 加入


`uuid方式`

```shell
abc@abc:~$ sudo blkid
/dev/sda2: UUID="e1fc5024-b88d-4781-948e-a9dab80baa76" TYPE="swap" PARTUUID="632674e3-689b-8248-bec8-cc673d81b2e2"
/dev/sda1: UUID="635E-10AB" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="93b17d02-33ab-4867-9379-2915b2e51fc0"
/dev/sda3: LABEL="bpool" UUID="2648003100764060318" UUID_SUB="13443058274032828838" TYPE="zfs_member" PARTUUID="a9865e02-3b35-2d4d-ac78-1829db423ce2"
/dev/sda4: LABEL="rpool" UUID="6340906846261585702" UUID_SUB="3921781473015350798" TYPE="zfs_member" PARTUUID="1adbab33-aaf6-ab4d-9d0f-a923cfbf2d17"
/dev/sdb: UUID="2DQOj7-Wf3r-ogYb-n0xF-zRl6-hVot-gcQonL" TYPE="LVM2_member"
/dev/loop0: TYPE="squashfs"
/dev/loop1: TYPE="squashfs"
/dev/loop2: TYPE="squashfs"
/dev/loop3: TYPE="squashfs"
/dev/loop4: TYPE="squashfs"
/dev/loop5: TYPE="squashfs"
/dev/loop6: TYPE="squashfs"
/dev/loop7: TYPE="squashfs"
/dev/sdc: UUID="7JwTbl-4aCX-dm6d-onYc-qadM-SVho-xR7Hcp" TYPE="LVM2_member"
/dev/sdd: UUID="MaYYjn-BI8u-kO8T-2VPk-Xp6g-Wwrg-ZXW1fs" TYPE="LVM2_member"
/dev/sde: UUID="YI7wvU-ODJm-w1PG-4RjV-FLu5-W6mo-98S1sD" TYPE="LVM2_member"
/dev/sdf: UUID="6mS1fC-ZHGU-CifE-TTww-bQcP-3ATW-m7gL15" TYPE="LVM2_member"
/dev/loop8: TYPE="squashfs"
/dev/loop9: TYPE="squashfs"
/dev/mapper/LVM-DB_DATA: UUID="9207d950-b182-42f8-ba6b-c2734494c4fe" TYPE="ext4"
/dev/mapper/LVM-DB: UUID="cf58f715-7c78-49a8-ad69-762b2ef1700a" TYPE="ext4"
```

```shell
UUID=cf58f715-7c78-49a8-ad69-762b2ef1700a /opt ext4 defaults 0 0
UUID=9207d950-b182-42f8-ba6b-c2734494c4fe /opt/workspace ext4 defaults 0 0
```

`label 方式(推荐)`

```shell
/dev/LVM/DB_DATA /opt ext4 defaults 0 0
/dev/LVM/DB /opt/workspace ext4 defaults 0 0
```

### 8、增加硬盘扩容

```shell
sudo pvcreate /dev/sdh # 增加硬盘


sudo vgextend LVM /dev/sdh # 扩展卷组（VG）


sudo lvextend -l +100%FREE /dev/LVM/DB_DATA # 增加到某个分区


sudo resize2fs /dev/LVM/DB_DATA  # 改变大小
```

### 9.删除逻辑盘

```shell
sudo lvremove LVM
sudo vgremove LVM

```




### 10.格式化

```shell
step1:
  注释掉 /etc/fstab 上面的挂载
step2: 删除逻辑卷
    sudo lvremove LVM
    sudo vgremove LVM
step3: 重新配置然后格式化

```

## SSHFS 挂载远程地址

SSHFS 可以把硬盘通过ssh 的方式进行挂载

```shell
sudo apt-get install sshfs
```

```shell
sudo sshfs -o allow_other,default_permissions abc@192.168.1.32:/home/abc/data /home/abc/data
```

```shell
umount mountpoint
```


## 可用资源

[redhat 官方挂载教程](https://access.redhat.com/documentation/zh-cn/red_hat_enterprise_linux/7/html/logical_volume_manager_administration/lv)

[sshfs github](https://github.com/libfuse/sshfs)