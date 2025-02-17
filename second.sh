#!/bin/bash
# https://github.com/bob-zebedy/OpenWrt-CI-RC

# Run after update feeds

MODE=$1
COMMIT_SHA=$2
if [ -z "$MODE" ]; then
    COMMIT_SHA='Unknown'
fi
if [ -z "$COMMIT_SHA" ]; then
    COMMIT_SHA='Unknown'
fi

# Modify default timezone
echo 'Modify default timezone...'
sed -i 's/UTC/Asia\/Shanghai/g' package/base-files/files/bin/config_generate

# Modify default NTP server
echo 'Modify default NTP server...'
sed -i 's/ntp.aliyun.com/ntp.ntsc.ac.cn/g' package/base-files/files/bin/config_generate
sed -i 's/time1.cloud.tencent.com/ntp.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/time.ustc.edu.cn/cn.ntp.org.cn/g' package/base-files/files/bin/config_generate
sed -i 's/cn.pool.ntp.org/pool.ntp.org/g' package/base-files/files/bin/config_generate

# Modify default LAN ip
echo 'Modify default LAN IP...'
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

# Modify default theme
echo 'Modify default theme...'
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify default luci-theme-argon
# https://github.com/bob-zebedy/luci-theme-argon
echo 'Modify default luci-theme-argon...'
rm -rf feeds/luci/themes/luci-theme-argon && git clone https://github.com/bob-zebedy/luci-theme-argon feeds/luci/themes/luci-theme-argon

# Modify default ttyd
# https://github.com/bob-zebedy/ttyd
echo 'Modify default ttyd...'
rm -rf feeds/packages/utils/ttyd && git clone https://github.com/bob-zebedy/ttyd.git feeds/packages/utils/ttyd

# Modify default gcc
# https://github.com/bob-zebedy/openwrt-gcc
echo 'Modify default gcc...'
rm -rf feeds/packages/devel/gcc && git clone https://github.com/bob-zebedy/openwrt-gcc.git feeds/packages/devel/gcc

# Modify zzz-default-settings
echo 'Delete `sed -i 's#downloads.openwrt.org#mirrors.cloud.tencent.com/lede#g' /etc/opkg/distfeeds.conf`...'
sed -i '/mirrors.cloud.tencent.com/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/openwrt_luci/d' package/lean/default-settings/files/zzz-default-settings

# Modify admin/status/overview <td id="wan4_i" style="width:16px; text-align:center; padding:3px">
echo 'Modify admin/status/overview <td id="wan4_i" style="width:16px; text-align:center; padding:3px">...'
sed -i 's/<td id="wan4_i" style="width:16px; text-align:center; padding:3px">/<td id="wan4_i" style="width:10%; text-align:center; padding:3px">/g' package/lean/autocore/files/x86/index.htm

# Modify admin/status/overview <td id="wan6_i" style="width:16px; text-align:center; padding:3px">
echo 'Modify admin/status/overview <td id="wan6_i" style="width:16px; text-align:center; padding:3px">...'
sed -i 's/<td id="wan6_i" style="width:16px; text-align:center; padding:3px">/<td id="wan6_i" style="width:10%; text-align:center; padding:3px">/g' package/lean/autocore/files/x86/index.htm

# Modify localtime in Homepage
echo 'Modify localtime in Homepage...'
sed -i 's/os.date()/os.date("%Y-%m-%d %H:%M:%S")/g' package/lean/autocore/files/x86/index.htm

# Add Firmware Commit Hash in Homepage
echo 'Add Firmware Commit Hash in Homepage...'
line_kernel_version=$(grep -n 'Kernel Version' package/lean/autocore/files/x86/index.htm | awk -F ':' '{print $1}')
sed -i "${line_kernel_version}a\                <tr><td width=\"33%\"><%:Build Version%></td><td>$COMMIT_SHA ($MODE)</td></tr>" package/lean/autocore/files/x86/index.htm

# Add Build Date in Homepage
echo 'Add Build Date in Homepage...'
build_date=$(date +"%Y-%m-%d %H:%M:%S")
line_build_version=$(grep -n 'Build Version' package/lean/autocore/files/x86/index.htm | awk -F ':' '{print $1}')
sed -i "${line_build_version}a\                <tr><td width=\"33%\"><%:Build Date%></td><td>${build_date}</td></tr>" package/lean/autocore/files/x86/index.htm

# Modify hostname in Homepage
echo 'Modify hostname...'
sed -i 's/${g}'"'"' - '"'"'//g' package/lean/autocore/files/x86/autocore

# Replace openwrt.org in diagnostics with www.baidu.com
echo 'Replace openwrt.org in diagnostics.htm with www.baidu.com...'
sed -i "/exit 0/d" package/lean/default-settings/files/zzz-default-settings
cat <<EOF >>package/lean/default-settings/files/zzz-default-settings
uci set luci.diag.ping=www.baidu.com
uci set luci.diag.route=www.baidu.com
uci set luci.diag.dns=www.baidu.com
uci commit luci

exit 0
EOF

# Modify default banner
echo 'Modify default banner...'
echo "                                                               " >package/base-files/files/etc/banner
echo " ██████╗ ██████╗ ███████╗███╗   ██╗██╗    ██╗██████╗ ████████╗ " >>package/base-files/files/etc/banner
echo "██╔═══██╗██╔══██╗██╔════╝████╗  ██║██║    ██║██╔══██╗╚══██╔══╝ " >>package/base-files/files/etc/banner
echo "██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║ █╗ ██║██████╔╝   ██║    " >>package/base-files/files/etc/banner
echo "██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║███╗██║██╔══██╗   ██║    " >>package/base-files/files/etc/banner
echo "╚██████╔╝██║     ███████╗██║ ╚████║╚███╔███╔╝██║  ██║   ██║    " >>package/base-files/files/etc/banner
echo " ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚══╝╚══╝ ╚═╝  ╚═╝   ╚═╝    " >>package/base-files/files/etc/banner
echo " ------------------------------------------------------------- " >>package/base-files/files/etc/banner
echo " %D %C ${build_date} $MODE @Zebedy                             " >>package/base-files/files/etc/banner
echo " $COMMIT_SHA                                                   " >>package/base-files/files/etc/banner
echo " ------------------------------------------------------------- " >>package/base-files/files/etc/banner
echo "                                                               " >>package/base-files/files/etc/banner
