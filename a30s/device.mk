DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

TARGET_LOCAL_ARCH := arm64

# Inherit common device configuration
$(call inherit-product, device/samsung/universal7885-common/universal7885-common.mk)

$(call inherit-product, vendor/samsung/a30s/a30s-vendor.mk)

$(call inherit-product, frameworks/native/build/phone-xhdpi-4096-dalvik-heap.mk)

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.3-service.samsung

TARGET_SCREEN_HEIGHT := 2280
TARGET_SCREEN_WIDTH := 1080

# Feature Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml
    
PRODUCT_PACKAGES += \
   fstab.exynos7904

PRODUCT_PACKAGES += \
   android.hardware.sensors@1.0-service

BUILD_FINGERPRINT := "samsung/a30sub/a30s:11/RP1A.200720.012/A307GUBS4CUJ1:user/release-keys"

PRODUCT_BUILD_PROP_OVERRIDES += \
   PRIVATE_BUILD_DESC="a30sub-user 11 RP1A.200720.012 A307GUBS4CUJ1 release-keys"
