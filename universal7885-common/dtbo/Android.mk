# BOARD_CUSTOM_DTBOIMG_MK := $(PLATFORM_PATH)/kernel/dtbo.mk

MKDTIMG := $(HOST_OUT_EXECUTABLES)/mkdtimg$(HOST_EXECUTABLE_SUFFIX)
KERNEL_OUT := $(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ
DTBO_DIR   := $(KERNEL_OUT)/arch/$(KERNEL_ARCH)/boot/dts/exynos/dtbo
DTBO_CFG := $(COMMON_PATH)/dtbo/$(TARGET_DEVICE).cfg

<<<<<<< HEAD
<<<<<<< HEAD
define build-dtboimage-target
    $(call pretty,"Target dtbo image: $(INSTALLED_DTBIMAGE_TARGET)")
    $(MKDTIMG) cfg_create $@ $(DTBO_CFG) -d $(DTBO_DIR)
    $(hide) chmod a+r $@
endef

$(INSTALLED_DTBIMAGE_TARGET): $(MKDTIMG) $(INSTALLED_KERNEL_TARGET)
	$(build-dtboimage-target)
=======
INSTALLED_DTBIMAGE_TARGET := $(PRODUCT_OUT)/eureka_dtbo.img
	
$(INSTALLED_DTBIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(MKDTIMG)
=======
INSTALLED_DTBIMAGE_TARGET := $(PRODUCT_OUT)/eureka_dtbo.img
	
$(INSTALLED_DTBIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(MKDTBOIMG)
>>>>>>> 5bf5dfd (universal7885: dtbo: fix race condition)
	$(call pretty,"Target dtbo image: $(INSTALLED_DTBIMAGE_TARGET)")
	$(hide) echo "Building eureka_dtbo.img"
	$(MKDTIMG) cfg_create $@ $(DTBO_CFG) -d $(DTBO_DIR)
	$(hide) $(call assert-max-image-size,$@,$(BOARD_DTBIMAGE_PARTITION_SIZE),raw)
	$(hide) chmod a+r $@
<<<<<<< HEAD
>>>>>>> 8c104e9 (fixup! universal7885: compile dtbo from the kernel rather than prebuilt)
=======
>>>>>>> 5bf5dfd (universal7885: dtbo: fix race condition)
	
.PHONY: dtbimage
dtbimage: $(INSTALLED_DTBIMAGE_TARGET)

INSTALLED_RADIOIMAGE_TARGET += $(INSTALLED_DTBIMAGE_TARGET)
