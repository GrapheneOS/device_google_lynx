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

# Bluetooth HAL and Pixel extension
DEVICE_MANIFEST_FILE += \
	device/google/lynx/bluetooth/manifest_bluetooth.xml

BOARD_SEPOLICY_DIRS += device/google/lynx-sepolicy/bluetooth

BOARD_HAVE_BLUETOOTH_QCOM = true
BOARD_USES_COMMON_BLUETOOTH_HAL = true
QCOM_BLUETOOTH_USING_DIAG = false
TARGET_BLUETOOTH_HCI_V1_1 = true
TARGET_BLUETOOTH_UART_DEVICE = "/dev/ttySAC18"
UART_USE_TERMIOS_AFC = true
TARGET_USE_QTI_BT_IBS = false
TARGET_USE_QTI_BT_OBS = false
TARGET_USE_QTI_BT_SAR = true
TARGET_USE_QTI_BT_CHANNEL_AVOIDANCE = true
ifeq ($(TARGET_BLUETOOTH_HCI_V1_1),true)
   PRODUCT_PACKAGES += android.hardware.bluetooth@1.1-impl-qti
else
   PRODUCT_PACKAGES += android.hardware.bluetooth@1.0-impl-qti
endif
PRODUCT_PACKAGES += \
	android.hardware.bluetooth@1.0-service-qti \
	hardware.google.bluetooth.sar@1.0-impl \
	hardware.google.bluetooth.bt_channel_avoidance@1.0-impl

# Bluetooth SAR test tools
PRODUCT_PACKAGES_DEBUG += \
	bluetooth_sar_test

# Bluetooth SoC, BDA in device tree, and WiPower
PRODUCT_PROPERTY_OVERRIDES += \
	vendor.qcom.bluetooth.soc=hastings \
	ro.vendor.bt.bdaddr_path=/proc/device-tree/chosen/config/bt_addr \
	ro.vendor.bluetooth.emb_wp_mode=false \
	ro.vendor.bluetooth.wipower=false

# Bluetooth A2DP offloading
PRODUCT_PROPERTY_OVERRIDES += \
	ro.bluetooth.a2dp_offload.supported=true \
	persist.bluetooth.a2dp_offload.disabled=true \
	persist.bluetooth.a2dp_offload.cap=sbc-aac-aptx-aptxhd-ldac

ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.service.bdroid.soclog=true \
	persist.vendor.service.bdroid.fwsnoop=true
else
PRODUCT_PROPERTY_OVERRIDES += \
	persist.vendor.service.bdroid.soclog=false \
	persist.vendor.service.bdroid.fwsnoop=false
endif
