# OpenWrt-CI 

自用 x86 软路由 OpenWrt 测试固件

![](https://img.shields.io/github/actions/workflow/status/deplives/OpenWrt-CI-RC/OpenWrt-Builder.yml?branch=main&label=%E6%89%8B%E5%8A%A8%E7%BC%96%E8%AF%91&style=flat-square)

## 固件特点

- Kernel 32 MB; Rootfs 256 MB
- 替换/新增了某些默认插件
- 修改默认主题为 argon
- 修改默认 NTP 服务器
    - ntp.ntsc.ac.cn 
    - ntp.aliyun.com 
    - cn.ntp.org.cn 
    - pool.ntp.org
- 修改默认时区为 Asia/Shanghai
- 修改默认 LAN IP 为 192.168.50.1
- 首页新增 '编译版本' 和 '编译日期'
- 修改默认 console banner 样式

## 替换插件

- [ttyd](https://github.com/deplives/ttyd)
- [luci-app-ttyd](https://github.com/deplives/luci-app-ttyd)

## 新增插件

- [HelloWorld](https://github.com/deplives/helloworld)
- [IPSec VPN](https://github.com/deplives/openwrt-package)
- [阿里 DDNS](https://github.com/deplives/openwrt-package)
