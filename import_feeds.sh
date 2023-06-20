#!/bin/bash

# Update and Install Feeds
./scripts/feeds update -a
./scripts/feeds install -a

git clone -b master --depth 1 https://github.com/immortalwrt/immortalwrt.git immortalwrt
git clone -b openwrt-21.02 --depth 1 https://github.com/immortalwrt/immortalwrt.git immortalwrt_21
git clone -b openwrt-23.05 --depth 1 https://github.com/immortalwrt/immortalwrt.git immortalwrt_23
git clone -b master --depth 1 https://github.com/immortalwrt/packages.git immortalwrt_pkg
git clone -b openwrt-21.02 --depth 1 https://github.com/immortalwrt/packages.git immortalwrt_pkg_21
git clone -b master --depth 1 https://github.com/immortalwrt/luci.git immortalwrt_luci
git clone -b openwrt-21.02 --depth 1 https://github.com/immortalwrt/luci.git immortalwrt_luci_21
git clone -b openwrt-23.05 --depth 1 https://github.com/immortalwrt/luci.git immortalwrt_luci_23
git clone -b master --depth 1 https://github.com/coolsnowwolf/lede.git lede
git clone -b master --depth 1 https://github.com/coolsnowwolf/luci.git lede_luci
git clone -b master --depth 1 https://github.com/coolsnowwolf/packages.git lede_pkg
git clone -b main --depth 1 https://github.com/openwrt/openwrt.git openwrt_ma
git clone -b openwrt-22.03 --depth 1 https://github.com/openwrt/openwrt.git openwrt_22
git clone -b master --depth 1 https://github.com/openwrt/packages.git openwrt_pkg_ma
git clone -b master --depth 1 https://github.com/openwrt/luci.git openwrt_luci_ma
git clone -b master --depth 1 https://github.com/Lienol/openwrt.git Lienol
git clone -b main --depth 1 https://github.com/Lienol/openwrt-package Lienol_pkg
git clone -b packages --depth 1 https://github.com/xiaorouji/openwrt-passwall passwall_pkg
git clone -b luci --depth 1 https://github.com/xiaorouji/openwrt-passwall passwall_luci
git clone -b master --depth 1 https://github.com/fw876/helloworld ssrp

git clone -b master --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/new/luci-theme-argon
rm -rf ./package/new/luci-theme-argon/htdocs/luci-static/argon/background/README.md
git clone -b master --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/new/luci-app-argon-config

cp -rf ../OpenWrt-Add/luci-app-cpufreq ./feeds/luci/applications/luci-app-cpufreq
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/10-cpufreq
cp -rf ../OpenWrt-Add/luci-app-cpulimit ./package/new/luci-app-cpulimit
cp -rf ../immortalwrt_pkg/utils/cpulimit ./feeds/packages/utils/cpulimit
ln -sf ../../../feeds/packages/utils/cpulimit ./package/feeds/packages/cpulimit

git clone -b master --depth 1 https://github.com/kiddin9/luci-theme-edge.git package/new/luci-theme-edge

git clone -b master --depth 1 https://github.com/NateLol/luci-app-oled.git package/new/luci-app-oled

git clone --single-branch --depth 1 -b dev https://github.com/vernesong/OpenClash.git package/new/luci-app-openclash

cp -rf ../passwall_luci/luci-app-passwall ./package/new/luci-app-passwall
cp -rf ../passwall_pkg/tcping ./package/new/tcping
cp -rf ../passwall_pkg/trojan-go ./package/new/trojan-go
cp -rf ../passwall_pkg/brook ./package/new/brook
cp -rf ../passwall_pkg/ssocks ./package/new/ssocks
cp -rf ../passwall_pkg/microsocks ./package/new/microsocks
cp -rf ../passwall_pkg/dns2socks ./package/new/dns2socks
cp -rf ../passwall_pkg/ipt2socks ./package/new/ipt2socks
cp -rf ../passwall_pkg/pdnsd-alt ./package/new/pdnsd-alt
cp -rf ../OpenWrt-Add/trojan-plus ./package/new/trojan-plus
cp -rf ../passwall_pkg/xray-plugin ./package/new/xray-plugin

cp -rf ../lede_luci/applications/luci-app-ramfree ./package/new/luci-app-ramfree

rm -rf ./feeds/packages/net/shadowsocks-libev
cp -rf ../lede_pkg/net/shadowsocks-libev ./package/new/shadowsocks-libev
cp -rf ../ssrp/redsocks2 ./package/new/redsocks2
cp -rf ../ssrp/trojan ./package/new/trojan
cp -rf ../ssrp/tcping ./package/new/tcping
cp -rf ../ssrp/dns2tcp ./package/new/dns2tcp
cp -rf ../ssrp/gn ./package/new/gn
cp -rf ../ssrp/shadowsocksr-libev ./package/new/shadowsocksr-libev
cp -rf ../ssrp/simple-obfs ./package/new/simple-obfs
cp -rf ../ssrp/naiveproxy ./package/new/naiveproxy
cp -rf ../ssrp/v2ray-core ./package/new/v2ray-core
cp -rf ../passwall_pkg/hysteria ./package/new/hysteria
cp -rf ../ssrp/sagernet-core ./package/new/sagernet-core
rm -rf ./feeds/packages/net/xray-core
cp -rf ../ssrp/xray-core ./package/new/xray-core
cp -rf ../ssrp/v2ray-plugin ./package/new/v2ray-plugin
cp -rf ../ssrp/shadowsocks-rust ./package/new/shadowsocks-rust
cp -rf ../ssrp/lua-neturl ./package/new/lua-neturl
rm -rf ./feeds/packages/net/kcptun
cp -rf ../immortalwrt_pkg/net/kcptun ./feeds/packages/net/kcptun
ln -sf ../../../feeds/packages/net/kcptun ./package/feeds/packages/kcptun

cp -rf ../ssrp/luci-app-ssr-plus ./package/new/luci-app-ssr-plus

cp -rf ../immortalwrt_luci/applications/luci-app-zerotier ./feeds/luci/applications/luci-app-zerotier