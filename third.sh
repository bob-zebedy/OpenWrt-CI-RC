#!/bin/bash
# https://github.com/bob-zebedy/OpenWrt-CI-RC

# Run after install feeds

# Add additional translations...
echo 'Add i18n in base.po...'
cat <<EOF >>feeds/luci/modules/luci-base/po/zh_Hans/base.po

msgid "Build Version"
msgstr "编译版本"

msgid "Build Date"
msgstr "编译日期"

msgid "try"
msgstr "尝试"

msgid "force"
msgstr "强制"

msgid "Do not send a Release when restarting"
msgstr "重启后前缀不释放"

msgid "Enable to minimise the chance of prefix change after a restart"
msgstr "启用以最大限度地减少重启后前缀更改的可能性"

EOF
