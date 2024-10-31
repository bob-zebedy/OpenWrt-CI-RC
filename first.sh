#!/bin/bash
# https://github.com/bob-zebedy/OpenWrt-CI-RC

# Uncomment a feed source
# echo 'Uncomment helloworld feed...'
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
# sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

MODE=$1 # stable beta

BRANCH_BOBBY='beta'
BRANCH_LEDE='beta'

if [ "$MODE" == "stable" ]; then
    BRANCH_BOBBY='main'
    BRANCH_LEDE='master'
elif [ "$MODE" == "beta" ]; then
    BRANCH_BOBBY='beta'
    BRANCH_LEDE='beta'
fi

echo 'Replace https://github.com/coolsnowwolf/packages'
sed -i "s/https:\/\/github.com\/coolsnowwolf\/packages/https:\/\/github.com\/bob-zebedy\/packages;$BRANCH_LEDE/g" feeds.conf.default

echo 'Replace https://github.com/coolsnowwolf/luci'
sed -i "s/https:\/\/github.com\/coolsnowwolf\/luci/https:\/\/github.com\/bob-zebedy\/luci/g" feeds.conf.default

echo 'Add helloworld feed...'
sed -i "$ a src-git helloworld https://github.com/bob-zebedy/helloworld;$BRANCH_BOBBY" feeds.conf.default

echo 'Add openwrt-package feed...'
sed -i "$ a src-git bobby https://github.com/bob-zebedy/openwrt-package;$BRANCH_BOBBY" feeds.conf.default

