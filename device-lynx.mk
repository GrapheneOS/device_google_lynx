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

TARGET_LINUX_KERNEL_VERSION := $(RELEASE_KERNEL_LYNX_VERSION)
# Keeps flexibility for kasan and ufs builds
TARGET_KERNEL_DIR ?= $(RELEASE_KERNEL_LYNX_DIR)
TARGET_BOARD_KERNEL_HEADERS ?= $(RELEASE_KERNEL_LYNX_DIR)/kernel-headers

$(call inherit-product-if-exists, vendor/google_devices/lynx/prebuilts/device-vendor-lynx.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs201/prebuilts/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/gs201/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/lynx/proprietary/lynx/device-vendor-lynx.mk)
$(call inherit-product-if-exists, vendor/google_devices/lynx/proprietary/device-vendor.mk)
$(call inherit-product-if-exists, vendor/google_devices/lynx/proprietary/WallpapersLynx.mk)

DEVICE_PACKAGE_OVERLAYS += device/google/lynx/lynx/overlay

include device/google/lynx/audio/lynx/audio-tables.mk
include device/google/gs201/device-shipping-common.mk
include hardware/google/pixel/vibrator/cs40l26/device.mk
include device/google/gs-common/touch/gti/gti.mk
include device/google/gs-common/wlan/dump.mk

# go/lyric-soong-variables
$(call soong_config_set,lyric,camera_hardware,lynx)
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

# Media Performance Class 13
PRODUCT_PROPERTY_OVERRIDES += ro.odm.build.media_performance_class=33

# Display Config
PRODUCT_COPY_FILES += \
        device/google/lynx/lynx/display_colordata_dev_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_colordata_dev_cal0.pb \
        device/google/lynx/lynx/display_golden_cal0.pb:$(TARGET_COPY_OUT_VENDOR)/etc/display_golden_cal0.pb

# Display
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.display.lbe.supported=1
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.set_idle_timer_ms=1000
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += ro.surface_flinger.ignore_hdr_camera_layers=true

#config of primary display frames to reach LHBM peak brightness
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += vendor.primarydisplay.lhbm.frames_to_reach_peak_brightness=2

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
	$(RELEASE_PACKAGE_NFC_STACK) \
	Tag \
	android.hardware.nfc-service.st \
	NfcOverlayLynx

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
PRODUCT_SOONG_NAMESPACES += \
    device/google/lynx/powerstats \
    device/google/lynx

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
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_common.mk)
ifeq ($(filter factory%, $(TARGET_PRODUCT)),)
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_shipping.mk)
else
$(call inherit-product-if-exists, vendor/goodix/udfps/configuration/udfps_factory.mk)
endif

# Vibrator HAL
$(call soong_config_set,haptics,kernel_ver,v$(subst .,_,$(TARGET_LINUX_KERNEL_VERSION)))
ADAPTIVE_HAPTICS_FEATURE := adaptive_haptics_v1
ACTUATOR_MODEL := legacy_zlra_actuator
PRODUCT_VENDOR_PROPERTIES += \
	ro.vendor.vibrator.hal.f0.comp.enabled=1 \
	ro.vendor.vibrator.hal.redc.comp.enabled=0 \
	persist.vendor.vibrator.hal.context.enable=false \
	persist.vendor.vibrator.hal.context.scale=40 \
	persist.vendor.vibrator.hal.context.fade=true \
	persist.vendor.vibrator.hal.context.cooldowntime=1600 \
	persist.vendor.vibrator.hal.context.settlingtime=5000

# Override Output Distortion Gain
PRODUCT_VENDOR_PROPERTIES += \
    vendor.audio.hapticgenerator.distortion.output.gain=0.29

# Trusty liboemcrypto.so
PRODUCT_SOONG_NAMESPACES += vendor/google_devices/lynx/prebuilts

# Location
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    PRODUCT_COPY_FILES += \
        device/google/lynx/location/lhd.conf.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/lhd.conf \
        device/google/lynx/location/scd.conf.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/scd.conf
    ifneq (,$(filter 6.1, $(TARGET_LINUX_KERNEL_VERSION)))
        PRODUCT_COPY_FILES += \
            device/google/lynx/location/gps.6.1.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
    else
        PRODUCT_COPY_FILES += \
            device/google/lynx/location/gps.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
    endif
else
    PRODUCT_COPY_FILES += \
        device/google/lynx/location/lhd_user.conf.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/lhd.conf \
        device/google/lynx/location/scd_user.conf.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/scd.conf
    ifneq (,$(filter 6.1, $(TARGET_LINUX_KERNEL_VERSION)))
        PRODUCT_COPY_FILES += \
            device/google/lynx/location/gps_user.6.1.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
    else
        PRODUCT_COPY_FILES += \
            device/google/lynx/location/gps_user.xml.l10:$(TARGET_COPY_OUT_VENDOR)/etc/gnss/gps.xml
    endif
endif

# Wifi HAL
PRODUCT_SOONG_NAMESPACES += hardware/qcom/wlan/wcn6740

# DCK properties based on target
PRODUCT_PROPERTY_OVERRIDES += \
    ro.gms.dck.eligible_wcc=2 \
    ro.gms.dck.se_capability=1

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

# Increment the SVN for any official public releases
ifdef RELEASE_SVN_LYNX
TARGET_SVN ?= $(RELEASE_SVN_LYNX)
else
# Set this for older releases that don't use build flag
TARGET_SVN ?= 46
endif

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.build.svn=$(TARGET_SVN)

# Set device family property for SMR
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.device_family=P10C10L10

# Set build properties for SMR builds
ifeq ($(RELEASE_IS_SMR), true)
    ifneq (,$(RELEASE_BASE_OS_LYNX))
        PRODUCT_BASE_OS := $(RELEASE_BASE_OS_LYNX)
    endif
endif

# Set build properties for EMR builds
ifeq ($(RELEASE_IS_EMR), true)
    ifneq (,$(RELEASE_BASE_OS_LYNX))
        PRODUCT_PROPERTY_OVERRIDES += \
        ro.build.version.emergency_base_os=$(RELEASE_BASE_OS_LYNX)
    endif
endif
# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

# Set support One-handed mode
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_one_handed_mode=true

# Fingerprint als feed forward
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.udfps.als_feed_forward_supported=true \
    persist.vendor.udfps.lhbm_controlled_in_hal_supported=true

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
	persist.vendor.camera.optimized_tnr_freq=1 \
	persist.vendor.camera.raise_buf_allocation_priority=1 \
	persist.vendor.camera.start_cpu_throttling_at_moderate_thermal=1

# Enable camera 1080P 60FPS binning mode
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.1080P_60fps_binning=true

# Increase thread priority for nodes stop
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.increase_thread_priority_nodes_stop=true

# OIS with system imu
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.ois_with_system_imu=true

# Enable camera exif model/make reporting
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.exif_reveal_make_model=true

# Enable front camera always binning for 720P or smaller resolution
PRODUCT_VENDOR_PROPERTIES += \
    persist.vendor.camera.front_720P_always_binning=true

# Device features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml

# The default value of this variable is false and should only be set to true when
# the device allows users to enable the seamless transfer feature.
PRODUCT_PRODUCT_PROPERTIES += \
   euicc.seamless_transfer_enabled_in_non_qs=true

##Audio Vendor property
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.audio.cca.enabled=false

# userdebug specific
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
    PRODUCT_COPY_FILES += \
        device/google/gs201/init.hardware.wlc.rc.userdebug:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.wlc.rc
endif

# SKU specific RROs
PRODUCT_PACKAGES += \
    SettingsOverlayG82U8 \
    SettingsOverlayG0DZQ \
    SettingsOverlayGHL1X \
    SettingsOverlayGWKK3

# Enable DeviceAsWebcam support
PRODUCT_VENDOR_PROPERTIES += \
    ro.usb.uvc.enabled=true

# Quick Start device-specific settings
PRODUCT_PRODUCT_PROPERTIES += \
    ro.quick_start.oem_id=00e0 \
    ro.quick_start.device_id=lynx

# Bluetooth device id
# Raven: 0x410B
PRODUCT_PRODUCT_PROPERTIES += \
    bluetooth.device_id.product_id=16651

# ETM
ifneq (,$(RELEASE_ETM_IN_USERDEBUG_ENG))
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
$(call inherit-product-if-exists, device/google/common/etm/device-userdebug-modules.mk)
endif
endif
