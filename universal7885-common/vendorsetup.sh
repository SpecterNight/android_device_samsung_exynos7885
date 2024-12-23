#!/bin/bash
UNIVERSAL="device/samsung/universal7885-common"
FM_PATH="packages/apps/FMRadio"

echo 'Starting Cloning repos for exynos7885'
echo 'Cloning Kernel tree [1/7]'
# Kernel for exynos7885
rm -rf kernel/samsung/exynos7885

git clone https://github.com/eurekadevelopment/Eureka-Kernel-Exynos7885-Q-R-S.git -b R15_rom kernel/samsung/exynos7885

echo 'Cloning Device Tree [2/7]'
# Device tree for exynos7885
rm -rf device/samsung

git clone https://github.com/SpecterNight/android_device_samsung_exynos7885.git -b android-11 device/samsung

cho 'Cloning Vendor Trees [3/7]'
# Vendor blobs for exynos7885
rm -rf vendor/samsung

git clone https://github.com/SpecterNight/android_vendor_samsung_exynos7885.git -b master vendor/samsung

echo 'Cloning Hardware Samsung [4/7]'
# Hardware OSS parts for Samsung
mv hardware/samsung/nfc .
rm -rf hardware/samsung
git clone https://github.com/Roynas-Android-Playground/android_hardware_samsung -b lineage-18.1 hardware/samsung
mv nfc hardware/samsung

echo 'Cloning Lineage-CP [6/7]'
# Lineage-CP
rm -rf hardware/samsung_slsi/libbt
rm -rf hardware/samsung_slsi/scsc_wifibt/wifi_hal
rm -rf hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib

git clone https://github.com/lineageos/android_hardware_samsung_slsi_libbt -b lineage-18.1 hardware/samsung_slsi/libbt
git clone https://github.com/lineageos/android_hardware_samsung_slsi_scsc_wifibt_wifi_hal -b lineage-18.1 hardware/samsung_slsi/scsc_wifibt/wifi_hal
git clone https://github.com/lineageos/android_hardware_samsung_slsi_scsc_wifibt_wpa_supplicant_lib -b lineage-18.1 hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib

echo 'Cloning Samsung_Slsi [7/7]'
# SLSI Sepolicy
rm -rf device/samsung_slsi/sepolicy
git clone https://github.com/Roynas-Android-Playground/android_device_samsung_slsi_sepolicy -b lineage-18.1 device/samsung_slsi/sepolicy

echo 'Completed, Now proceeding to lunch'

if test -f ${UNIVERSAL}/vendor_name; then
	rm ${UNIVERSAL}/vendor_name
fi
python3 ${UNIVERSAL}/vendor_detect/main.py
for dev in a10dd a10 a20 a20e a30 a30s a40; do
	echo "Generating ${dev} Makefiles..."
	bash ${UNIVERSAL}/setup.sh "$dev"
done

if [ ! -e .repo/local_manifests/eureka_deps.xml ]; then
	git clone https://github.com/SpecterNight/local_manifests .repo/local_manifests
	echo "Run repo sync again"
fi
