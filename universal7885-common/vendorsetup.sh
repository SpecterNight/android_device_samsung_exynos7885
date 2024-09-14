#!/bin/bash
UNIVERSAL="device/samsung/universal7885-common"
FM_PATH="packages/apps/FMRadio"

echo 'Starting Cloning repos for exynos7885'
echo 'Cloning Kernel tree [1/6]'
# Kernel for exynos7885
rm -rf kernel/samsung/exynos7885

git clone https://github.com/eurekadevelopment/Eureka-Kernel-Exynos7885-Q-R-S.git -b R15_rom kernel/samsung/exynos7885

echo 'Cloning Device Tree [2/6]'
# Device tree for exynos7885
rm -rf device/samsung

git clone https://github.com/SpecterNight/android_device_samsung_exynos7885.git -b android-11 device/samsung

cho 'Cloning Vendor Trees [3/6]'
# Vendor blobs for exynos7885
rm -rf vendor/samsung

git clone https://github.com/eurekadevelopment/android_vendor_samsung_exynos7885.git -b android-12.1 vendor/samsung

echo 'Cloning Hardware Samsung [4/6]'
# Hardware OSS parts for Samsung
mv hardware/samsung/nfc .
rm -rf hardware/samsung
git clone https://github.com/lineageos/android_hardware_samsung -b lineage-18.1 hardware/samsung
mv nfc hardware/samsung

echo 'Cloning Lineage-CP [6/6]'
# Lineage-CP
rm -rf hardware/samsung_slsi/libbt
rm -rf hardware/samsung_slsi/scsc_wifibt/wifi_hal
rm -rf hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib

git clone https://github.com/lineageos/android_hardware_samsung_slsi_libbt -b lineage-18.1 hardware/samsung_slsi/libbt
git clone https://github.com/lineageos/android_hardware_samsung_slsi_scsc_wifibt_wifi_hal -b lineage-18.1 hardware/samsung_slsi/scsc_wifibt/wifi_hal
git clone https://github.com/lineageos/android_hardware_samsung_slsi_scsc_wifibt_wpa_supplicant_lib -b lineage-18.1 hardware/samsung_slsi/scsc_wifibt/wpa_supplicant_lib

echo 'Completed, Now proceeding to lunch'

if test -f ${UNIVERSAL}/vendor_name; then
	rm ${UNIVERSAL}/vendor_name
fi
python3 ${UNIVERSAL}/vendor_detect/main.py
for dev in a10dd a10 a20 a20e a30 a30s a40; do
	echo "Generating ${dev} Makefiles..."
	bash ${UNIVERSAL}/setup.sh "$dev"
done

# For FM Radio
if grep -q isAudioServerUid\(callingUid\) frameworks/av/services/audioflinger/AudioFlinger.cpp; then
	echo "Applying FM routing patch"
	sed -i 's/isAudioServerUid(callingUid)/isAudioServerOrSystemServerUid(callingUid)/g' frameworks/av/services/audioflinger/AudioFlinger.cpp
fi
# Remove multiple declared FMRadio path (we have our own FMRadio and this cause build error)
if [ -d "$FM_PATH" ]; then
	echo "Remove FMRadio from ROM Source"
	rm -Rf $FM_PATH
fi

if [ ! -e .repo/local_manifests/eureka_deps.xml ]; then
	git clone https://github.com/SpecterNight/local_manifests .repo/local_manifests
	echo "Run repo sync again"
fi
