#!/bin/bash
#============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#============================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/XiaoMi_R3G/g' package/base-files/files/bin/config_generate

# 增加 SSID 2.5G
sed -i '/channel="11"/a\\t\tssid="OpenWrt-2G"' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 增加 SSID 5.0G
sed -i '/channel="36"/a\\t\t\tssid="OpenWrt-5G"' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
