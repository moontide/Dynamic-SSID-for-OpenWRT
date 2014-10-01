Dynamic-SSID-for-OpenWRT
========================

这是针对能够使用 OpenWRT 软固件、且支持多个 SSID 的路由器而写的一些动态改变 SSID 的脚本的收集。目的仅仅在于好玩。

各个脚本从不同的源头采集信息，然后根据采集到的内容去改变 SSID，然后这些 SSID 名称就变成了信息广播的媒体了！

我所用的路由器是 TP-Link 的 WR841N (硬件版本: v5/v6)，能够支持 8 个 SSID，除了正常使用的一个外，其他 7 个可用来广播信息 ~\_~
举例：每天早晨从 http://kernel.org 获取最新的 linux 内核版本信息，并设置为 SSID 名称，以进行广播

* SSID 2: `3.17-rc7 2014-09-28`
* SSID 3: `3.16.3 2014-09-17`
* SSID 4: `3.14.19 2014-09-17`
* SSID 5: `3.12.29 2014-09-30`
* SSID 6: `3.10.55 2014-09-17`
* SSID 7: `3.4.104 2014-09-25`
* SSID 8: `3.2.63 2014-09-13`


截图 | Screenshots
==================

distrowatch-distributions.sh
![DistroWatch latest distributions](https://github.com/moontide/Dynamic-SSID-for-OpenWRT/raw/master/screenshots/distrowatch-latest-distributions.png)
