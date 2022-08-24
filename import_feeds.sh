#!/bin/bash

# Update and Install Feeds
./scripts/feeds update -a
./scripts/feeds install -a

# Patch ARM64 name
wget -P target/linux/generic/hack-5.10/ https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.10/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# luci-theme-argon
git clone -b master --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b master --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/applications/luci-app-argon-config

# luci-theme-edge
git clone -b master --depth 1 https://github.com/kiddin9/luci-theme-edge.git package/new/luci-theme-edge

# Autocore
svn export https://github.com/immortalwrt/immortalwrt/branches/master/package/emortal/autocore feeds/packages/utils/autocore
sed -i 's/"getTempInfo" /"getTempInfo", "getCPUBench", "getCPUUsage" /g' feeds/packages/utils/autocore/files/generic/luci-mod-status-autocore.json

# Coremark
rm -rf ./feeds/packages/utils/coremark
svn export https://github.com/immortalwrt/packages/trunk/utils/coremark feeds/packages/utils/coremark

# Remove some net packages
rm -rf ./feeds/packages/net/https-dns-proxy
rm -rf ./feeds/packages/net/kcptun
rm -rf ./feeds/packages/net/shadowsocks-libev
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/brook
rm -rf ./feeds/packages/net/chinadns-ng
rm -rf ./feeds/packages/net/hysteria
rm -rf ./feeds/packages/net/ssocks
rm -rf ./feeds/packages/net/trojan
rm -rf ./feeds/packages/net/trojan-go
rm -rf ./feeds/packages/net/trojan-plus
rm -rf ./feeds/packages/net/sagernet-core
rm -rf ./feeds/packages/net/naiveproxy
rm -rf ./feeds/packages/net/shadowsocks-rust
rm -rf ./feeds/packages/net/shadowsocksr-libev
rm -rf ./feeds/packages/net/simple-obfs
rm -rf ./feeds/packages/net/tcping
rm -rf ./feeds/packages/net/v2ray-core
rm -rf ./feeds/packages/net/v2ray-geodata
rm -rf ./feeds/packages/net/v2ray-plugin
rm -rf ./feeds/packages/net/v2raya
rm -rf ./feeds/packages/net/xray-core
rm -rf ./feeds/packages/net/xray-plugin
rm -rf ./feeds/packages/net/dns2socks
rm -rf ./feeds/packages/net/microsocks
rm -rf ./feeds/packages/net/ipt2socks
rm -rf ./feeds/packages/net/pdnsd-alt
rm -rf ./feeds/packages/net/redsocks2

# Dependencies
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/brook feeds/packages/net/brook
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng feeds/packages/net/chinadns-ng
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/dns2tcp feeds/packages/net/dns2tcp
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria feeds/packages/net/hysteria
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks feeds/packages/net/ssocks
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go feeds/packages/net/trojan-go
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus feeds/packages/net/trojan-plus
svn export https://github.com/xiaorouji/openwrt-passwall/trunk/sagernet-core feeds/packages/net/sagernet-core
svn export https://github.com/fw876/helloworld/trunk/naiveproxy feeds/packages/net/naiveproxy
svn export https://github.com/immortalwrt/packages/trunk/net/shadowsocks-libev feeds/packages/net/shadowsocks-libev
svn export https://github.com/fw876/helloworld/trunk/shadowsocks-rust feeds/packages/net/shadowsocks-rust
svn export https://github.com/fw876/helloworld/trunk/shadowsocksr-libev feeds/packages/net/shadowsocksr-libev
svn export https://github.com/fw876/helloworld/trunk/simple-obfs feeds/packages/net/simple-obfs
svn export https://github.com/fw876/helloworld/trunk/tcping feeds/packages/net/tcping
svn export https://github.com/fw876/helloworld/trunk/trojan feeds/packages/net/trojan
svn export https://github.com/fw876/helloworld/trunk/v2ray-core feeds/packages/net/v2ray-core
svn export https://github.com/fw876/helloworld/trunk/v2ray-geodata feeds/packages/net/v2ray-geodata
svn export https://github.com/fw876/helloworld/trunk/v2ray-plugin feeds/packages/net/v2ray-plugin
svn export https://github.com/fw876/helloworld/trunk/v2raya feeds/packages/net/v2raya
svn export https://github.com/solomonricky/openwrt-passwall/branches/xray-wss/xray-core feeds/packages/net/xray-core
svn export https://github.com/fw876/helloworld/trunk/xray-plugin feeds/packages/net/xray-plugin
svn export https://github.com/fw876/helloworld/trunk/lua-neturl feeds/packages/net/lua-neturl
svn export https://github.com/immortalwrt/packages/trunk/net/dns2socks feeds/packages/net/dns2socks
svn export https://github.com/immortalwrt/packages/trunk/net/microsocks feeds/packages/net/microsocks
svn export https://github.com/immortalwrt/packages/trunk/net/ipt2socks feeds/packages/net/ipt2socks
svn export https://github.com/immortalwrt/packages/trunk/net/pdnsd-alt feeds/packages/net/pdnsd-alt
svn export https://github.com/immortalwrt/packages/trunk/net/redsocks2 feeds/packages/net/redsocks2
svn export https://github.com/immortalwrt/packages/trunk/net/https-dns-proxy feeds/packages/net/https-dns-proxy
svn export https://github.com/immortalwrt/packages/trunk/net/kcptun feeds/packages/net/kcptun
svn export https://github.com/kiddin9/openwrt-bypass/trunk/lua-maxminddb feeds/packages/net/lua-maxminddb
svn export https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/kernel/shortcut-fe
svn export https://github.com/immortalwrt/packages/trunk/net/dnsforwarder feeds/packages/net/dnsforwarder

# luci-app-bypass
svn export https://github.com/kiddin9/openwrt-bypass/trunk/luci-app-bypass feeds/luci/applications/luci-app-bypass

# luci-app-cpufreq
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq

# luci-app-openclash
git clone --single-branch --depth 1 -b dev https://github.com/vernesong/OpenClash.git feeds/luci/applications/luci-app-openclash

# luci-app-passwall
svn export https://github.com/solomonricky/openwrt-passwall/branches/luci-nodns/luci-app-passwall feeds/luci/applications/luci-app-passwall

# luci-app-passwall2
svn export https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 feeds/luci/applications/luci-app-passwall2

# luci-app-ramfree
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-ramfree feeds/luci/applications/luci-app-ramfree

# luci-app-ssr-plus
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus feeds/luci/applications/luci-app-ssr-plus

#luci-app-turboacc
#svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-turboacc feeds/luci/applications/luci-app-turboacc

# luci-app-vssr
git clone -b master --depth 1 https://github.com/jerrykuku/luci-app-vssr.git feeds/luci/applications/luci-app-vssr

# luci-app-zerotier
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-zerotier feeds/luci/applications/luci-app-zerotier

# IPv6 Helper
svn export https://github.com/immortalwrt/immortalwrt/trunk/package/emortal/ipv6-helper package/addon/ipv6-helper

# Change "Allow connection to 65535"
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# Update and Install Feeds
./scripts/feeds update -a
./scripts/feeds install -a -f
