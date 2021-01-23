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

# 设置时区
sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate

# 增加IPV6
sed -i '/exit 0/i\# 增加IPV6\nuci set network.globals.ula_prefix="ddaa:6666:8888::/48"\nuci commit network' package/lean/default-settings/files/zzz-default-settings
curl -fsSL https://raw.githubusercontent.com/danxiaonuo/AutoBuild-OpenWrt/master/99-ipv6 > package/base-files/files/etc/hotplug.d/99-ipv6
sed -i '/exit 0/i\mv /etc/hotplug.d/99-ipv6 /etc/hotplug.d/iface/99-ipv6' package/lean/default-settings/files/zzz-default-settings
sed -i '/99-ipv6/a\chmod u+x /etc/hotplug.d/iface/99-ipv6' package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/i\sed -i "s/option ip6assign ".*"/option ip6assign "64"/g" /etc/config/network' package/lean/default-settings/files/zzz-default-settings

# 增加IPV6防火墙
sed -i '/uci commit network/a\# IPV6防火墙\necho "ip6tables -t nat -I POSTROUTING -s $(uci get network.globals.ula_prefix) -j MASQUERADE" >> /etc/firewall.user' package/lean/default-settings/files/zzz-default-settings

# Modify WiFi ON
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 增加 SSID 2.5G
sed -i '/channel="11"/a\\t\tssid="danxiaonuo-2HZ"' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 增加 SSID 5.0G
sed -i '/channel="36"/a\\t\t\tssid="danxiaonuo-5HZ"' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default SSID
# sed -i 's/ssid=OpenWrt/ssid=XXX/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 修改 argon 为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
