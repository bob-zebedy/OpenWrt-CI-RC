#!/bin/bash
# https://github.com/bob-zebedy/OpenWrt-CI-RC

for patchfile in $(ls -a patches); do
    if [ "${patchfile##*.}" == "patch" ]; then
        patch -p1 <patches/$patchfile
    fi
done
