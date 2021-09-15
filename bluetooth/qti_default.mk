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

BOARD_HAVE_BLUETOOTH_QCOM = true
BOARD_USES_COMMON_BLUETOOTH_HAL = true
QCOM_BLUETOOTH_USING_DIAG = false
TARGET_BLUETOOTH_UART_DEVICE = "/dev/ttySAC18"
UART_USE_TERMIOS_AFC = true
TARGET_USE_QTI_BT_OBS = true
TARGET_USE_QTI_BT_SAR = true
TARGET_USE_QTI_BT_CHANNEL_AVOIDANCE = true
PRODUCT_PACKAGES += \
	android.hardware.bluetooth@1.0-service-qti \
	android.hardware.bluetooth@1.0-impl-qti \
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

