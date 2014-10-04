Dynamic-SSID-for-OpenWRT
========================

这是针对能够使用 OpenWRT 软固件、且支持多个 SSID 的路由器而写的一些动态改变 SSID 的脚本的收集。目的仅仅在于好玩。
This is a collection of scripts which changing SSID for those routers which can be supported by OpenWRT and support multiple SSIDs. It's just for fun.

各个脚本从不同的源头采集信息，然后根据采集到的内容去改变 SSID，然后这些 SSID 名称就变成了信息广播的媒体了！
All scripts grabbed information from different sources, and change SSID according these information, and then the SSID names become to information broadcast medias!

我所用的路由器是 TP-Link 的 WR841N (硬件版本: v5/v6)，能够支持 8 个 SSID，除了正常使用的一个外，其他 7 个可用来广播信息 ~\_~。举例：每天早晨从 http://distrowatch.com 获取最新的 linux 发行版本版本，并设置为 SSID 名称，以进行广播：
My router model is TP-Link WR841N (hardware version: v5/v6), it can support 8 SSID names. Beside the one used for normal connection, 7 others can be used for broadcasting. eg. grab the latest linux distrobutions information from  http://distrowatch.com, and set time as SSID name:

* SSID 2: `10/01 Arch 2014.10.01`
* SSID 3: `10/01 KNOPPIX 7.4.2`
* SSID 4: `10/01 LXLE 14.04.1-rc3`
* SSID 5: `10/01 LXLE 12.04.5-rc3`
* SSID 6: `09/30 Plop 4.3.0-test1`
* SSID 7: `09/30 Chakra 2014.09`
* SSID 8: `09/30 IPCop 2.1.6-rc1`


截图 | Screenshots
==================

## DistroWatch 网站的最新 linux 发行版信息 | distrowatch-latest-distributions.sh ##

![DistroWatch 网站的最新 linux 发行版信息 | DistroWatch latest distributions](https://github.com/moontide/Dynamic-SSID-for-OpenWRT/raw/master/screenshots/distrowatch-latest-distributions.png)

## cnbeta 手机版最新新闻 | cnbeta-mobile-news.sh ##

新闻来源： http://m.cnbeta.com/wap
News source: http://m.cnbeta.com/wap

这是演示在 SSID 中使用汉字的情况。
This one shows how to deal Chinese (or other multiple bytes characters) in SSID name.

通常来说，一个汉字的 UTF-8 编码后的字节长度为 3，而 SSID 最大长度为 32 字节，所以最多就只能存放 10 个汉字 + 2 个英文字符了。 但为了应对中英文混杂的情况（中文字符少于 10 个字符，但整体多于 10 个字符），需要处理 UTF-8 字节序列被截断的情况。处理后，可以使得 SSID 内容长度最大化（若只取 10 个汉字，则还剩下 2 个字节未用； 若只取 10 个英文字符，则剩下 22 个字节未用）
Usually, the length of a UTF-8 encoded Chinese character is 3 bytes, and max length of SSID name is 32 byts, so it can only contains no more 10 Chinese characters + 2 ASCII charactesr. But in the case of Chinese characters and ASCII characters are mixed, we need to deal the UTF-8 bytes sequence truncation situation. After fixing, the content length of SSID can be maximized.

![cnbeta 手机版新闻 | cnbeta mobile news](https://github.com/moontide/Dynamic-SSID-for-OpenWRT/raw/master/screenshots/cnbeta-mobile-news.png)
