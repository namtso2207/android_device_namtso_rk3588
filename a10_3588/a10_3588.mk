#
# Copyright 2014 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# First lunching is T, api_level is 33
PRODUCT_SHIPPING_API_LEVEL := 33
PRODUCT_DTBO_TEMPLATE := $(LOCAL_PATH)/dt-overlay.in

include device/namtso/common/build/rockchip/DynamicPartitions.mk
include device/namtso/rk3588/a10_3588/BoardConfig.mk
include device/namtso/common/BoardConfig.mk
$(call inherit-product, device/namtso/rk3588/device.mk)
$(call inherit-product, device/namtso/common/device.mk)
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/../overlay

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_NAME := a10_3588
PRODUCT_DEVICE := a10_3588
PRODUCT_BRAND := rockchip
PRODUCT_MODEL := A10_3588
PRODUCT_MANUFACTURER := Namtso
PRODUCT_AAPT_PREF_CONFIG := mdpi

$(shell python device/namtso/rk3588/auto_generator.py preinstall)
-include device/namtso/rk3588/preinstall/preinstall.mk
PRODUCT_COPY_FILES += \
    device/namtso/rk3588/preinstall/preinstall.sh:system/bin/preinstall.sh \
    device/namtso/rk3588/a10_3588/candump:system/bin/candump \
    device/namtso/rk3588/a10_3588/cansend:system/bin/cansend \
    device/namtso/rk3588/a10_3588/android_usb_mac_tool/rtunicpg-aarch64-armv8:system/bin/rtunicpg-aarch64-armv8 \
    device/namtso/rk3588/a10_3588/android_usb_mac_tool/EF8156BG.dat:system/usr/share/android_usb_mac_tool/EF8156BG.dat \
    device/namtso/rk3588/a10_3588/android_pcie_mac_tool/rtnicpg-aarch64-linux-gnu:system/bin/rtnicpg-aarch64-linux-gnu \
    device/namtso/rk3588/a10_3588/android_pcie_mac_tool/pgdrv.ko:system/usr/share/android_pcie_mac_tool/pgdrv.ko \
    device/namtso/rk3588/a10_3588/android_pcie_mac_tool/pgload.sh:system/usr/share/android_pcie_mac_tool/pgload.sh \

#
## add Rockchip properties
#
PRODUCT_PROPERTY_OVERRIDES += ro.kofficial.version=false
PRODUCT_PROPERTY_OVERRIDES += ro.kofficial.otaurl=https://dl.namtso.com/products/a10/a10-3588/firmware/android/ota/
PRODUCT_PROPERTY_OVERRIDES += ro.sf.lcd_density=240
PRODUCT_PROPERTY_OVERRIDES += ro.wifi.sleep.power.down=true
PRODUCT_PROPERTY_OVERRIDES += persist.wifi.sleep.delay.ms=0
PRODUCT_PROPERTY_OVERRIDES += persist.bt.power.down=true
PRODUCT_PROPERTY_OVERRIDES += persist.sys.rotation.efull=true
PRODUCT_PROPERTY_OVERRIDES += persist.demo.hdmirotates=true
PRODUCT_PROPERTY_OVERRIDES += ro.config.media_vol_default=12
PRODUCT_PROPERTY_OVERRIDES += vendor.hwc.enable_dynamic_display_mode=1

PRODUCT_PROPERTY_OVERRIDES += service.adb.tcp.port=5555
BUILD_NUMBER2 := $(shell $(DATE) +%Y%m%d)
PRODUCT_PROPERTY_OVERRIDES += ro.build.display.id=A10-3588-android-13-v$(BUILD_NUMBER2)
