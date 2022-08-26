#
# Copyright (C) 2021 The Android Open-Source Project
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

TARGET_KERNEL_DIR ?= device/google/lynx-kernel
TARGET_BOARD_KERNEL_HEADERS := device/google/lynx-kernel/kernel-headers

$(call inherit-product-if-exists, vendor/google_devices/lynx/prebuilts/device-vendor-lynx.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs201/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs201/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/lynx/proprietary/lynx/device-vendor-lynx.mk)
$(call inherit-product-if-exists, vendor/google_devices/lynx/proprietary/device-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/google/lynx/lynx/overlay

include device/google/lynx/audio/lynx/audio-tables.mk
include device/google/gs201/device-shipping-common.mk
include hardware/google/pixel/vibrator/cs40l26/device.mk

$(call soong_config_set,lyric,tuning_product,lynx)
$(call soong_config_set,google3a_config,target_device,lynx)

# Init files
PRODUCT_COPY_FILES += \
	device/google/lynx/conf/init.lynx.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.lynx.rc

# Recovery files
PRODUCT_COPY_FILES += \
        device/google/lynx/conf/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.lynx.rc

# insmod files
PRODUCT_COPY_FILES += \
	device/google/lynx/init.insmod.lynx.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/init.insmod.lynx.cfg

# Camera
PRODUCT_COPY_FILES += \
	device/google/lynx/media_profiles_lynx.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml

# Display Config
PRODUCT_COPY_FILES += \
        device/google/lynx/lynx/display_colordata_dev_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_colordata_dev_cal0.pb
# Display
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms=1500
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

# NFC
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
	frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
	frameworks/native/data/etc/android.hardware.nfc.hcef.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hcef.xml \
	frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.nxp.mifare.xml \
	frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.ese.xml \
	device/google/lynx/nfc/libnfc-hal-st.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-hal-st.conf \
    device/google/lynx/nfc/libnfc-nci-lynx.conf:$(TARGET_COPY_OUT_PRODUCT)/etc/libnfc-nci.conf

PRODUCT_PACKAGES += \
	NfcNci \
	Tag \
	android.hardware.nfc-service.st

# SecureElement
PRODUCT_PACKAGES += \
	android.hardware.secure_element@1.2-service-gto \
	android.hardware.secure_element@1.2-service-gto-ese2

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.ese.xml \
	frameworks/native/data/etc/android.hardware.se.omapi.uicc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.se.omapi.uicc.xml \
	device/google/lynx/nfc/libse-gto-hal.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal.conf \
	device/google/lynx/nfc/libse-gto-hal2.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libse-gto-hal2.conf

DEVICE_MANIFEST_FILE += \
	device/google/lynx/nfc/manifest_se.xml

# Thermal Config
PRODUCT_COPY_FILES += \
	device/google/lynx/thermal_info_config_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config.json \
	device/google/lynx/thermal_info_config_charge_lynx.json:$(TARGET_COPY_OUT_VENDOR)/etc/thermal_info_config_charge.json

# Power HAL config
PRODUCT_COPY_FILES += \
	device/google/lynx/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

# PowerStats HAL
PRODUCT_SOONG_NAMESPACES += device/google/lynx/powerstats

# Bluetooth HAL and Pixel extension
include device/google/lynx/bluetooth/qti_default.mk

# Keymaster HAL
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# Gatekeeper HAL
#LOCAL_GATEKEEPER_PRODUCT_PACKAGE ?= android.hardware.gatekeeper@1.0-service.software


# Gatekeeper
# PRODUCT_PACKAGES += \
# 	android.hardware.gatekeeper@1.0-service.software

# Keymint replaces Keymaster
# PRODUCT_PACKAGES += \
# 	android.hardware.security.keymint-service

# Keymaster
#PRODUCT_PACKAGES += \
#	android.hardware.keymaster@4.0-impl \
#	android.hardware.keymaster@4.0-service

#PRODUCT_PACKAGES += android.hardware.keymaster@4.0-service.remote
#PRODUCT_PACKAGES += android.hardware.keymaster@4.1-service.remote
#LOCAL_KEYMASTER_PRODUCT_PACKAGE := android.hardware.keymaster@4.1-service
#LOCAL_KEYMASTER_PRODUCT_PACKAGE ?= android.hardware.keymaster@4.1-service

# PRODUCT_PROPERTY_OVERRIDES += \
# 	ro.hardware.keystore_desede=true \
# 	ro.hardware.keystore=software \
# 	ro.hardware.gatekeeper=software

# Fingerprint HAL
GOODIX_CONFIG_BUILD_VERSION := g7_trusty
include device/google/gs101/fingerprint/udfps_common.mk
ifeq ($(filter factory%, $(TARGET_PRODUCT)),)
include device/google/gs101/fingerprint/udfps_shipping.mk
else
include device/google/gs101/fingerprint/udfps_factory.mk
endif

# Vibrator HAL
PRODUCT_VENDOR_PROPERTIES += \
	ro.vendor.vibrator.hal.supported_primitives=243

# Trusty liboemcrypto.so
PRODUCT_SOONG_NAMESPACES += vendor/google_devices/lynx/prebuilts

# GPS xml
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
        PRODUCT_COPY_FILES += \
                device/google/lynx/gps.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
else
        PRODUCT_COPY_FILES += \
                device/google/lynx/gps_user.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
endif

# DCK properties based on target
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gms.dck.eligible_wcc=2

# WIFI COEX
PRODUCT_COPY_FILES += \
	device/google/lynx/wifi/coex_table.xml:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/coex_table.xml

# WiFi Overlay
PRODUCT_PACKAGES += \
	WifiOverlay2023Mid

# Wifi Aware Interface
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.aware.interface=wifi-aware0

# Set zram size
PRODUCT_VENDOR_PROPERTIES += \
	vendor.zram.size=3g

# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

# Set support One-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Hide cutout overlays
PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

# MIPI Coex Configs
PRODUCT_COPY_FILES += \
    device/google/lynx/lynx/radio/lynx_display_primary_mipi_coex_table.csv:$(TARGET_COPY_OUT_VENDOR)/etc/modem/display_primary_mipi_coex_table.csv

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.camera.extended_launch_boost=1 \
	persist.vendor.camera.raise_buf_allocation_priority=1

# Enable camera 1080P 60FPS binning mode
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.1080P_60fps_binning=true

# Limit camera 1080P 60FPS binning mode to not rear main camera
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.1080P_60fps_binning_except_rear_main=true

# OIS with system imu
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.ois_with_system_imu=true

# Device features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml
