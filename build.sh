echo -e "Making moto g (falcon) zImage\n"
export PATH=$PATH:~/toolchains/linaro4.9_Cortex-A7/bin
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=arm-eabi-

make falcon_defconfig

make -j4

# modules
find ./ -type f -name '*.ko' -exec cp -f {} ../zip/system/lib/modules/ \;
mv ../zip/system/lib/modules/wlan.ko ../zip/system/lib/modules/pronto/pronto_wlan.ko

# copy zImage
cp -f arch/arm/boot/zImage-dtb ../zip/kernel/
ls -l ../zip/kernel/zImage-dtb
cd ../zip
zip -r -9 moto_G.zip * > /dev/null
mv moto_G.zip ../