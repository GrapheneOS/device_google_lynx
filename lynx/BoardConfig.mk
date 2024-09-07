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

TARGET_BOARD_INFO_FILE := device/google/lynx/board-info.txt
TARGET_BOOTLOADER_BOARD_NAME := lynx

RELEASE_GOOGLE_PRODUCT_RADIO_DIR := $(RELEASE_GOOGLE_LYNX_RADIO_DIR)
RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR ?= pdk# Keep this for pdk TODO: b/327119000
RELEASE_GOOGLE_PRODUCT_BOOTLOADER_DIR := bootloader/$(RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR)
$(call soong_config_set,lynx_bootloader,prebuilt_dir,$(RELEASE_GOOGLE_BOOTLOADER_LYNX_DIR))

ifdef PHONE_CAR_BOARD_PRODUCT
        include vendor/auto/embedded/products/$(PHONE_CAR_BOARD_PRODUCT)/BoardConfig.mk
else
        TARGET_SCREEN_DENSITY := 420
endif

BOARD_USES_GENERIC_AUDIO := true
USES_DEVICE_GOOGLE_LYNX := true

# Enable load module in parallel
BOARD_BOOTCONFIG += androidboot.load_modules_parallel=true

# The modules which need to be loaded in sequential
BOARD_KERNEL_CMDLINE += fips140.load_sequential=1
BOARD_KERNEL_CMDLINE += exynos_drm.load_sequential=1

include device/google/gs201/BoardConfig-common.mk
-include vendor/google_devices/gs201/prebuilts/BoardConfigVendor.mk
include device/google/gs-common/check_current_prebuilt/check_current_prebuilt.mk
-include vendor/google_devices/lynx/proprietary/BoardConfigVendor.mk
include device/google/lynx-sepolicy/lynx-sepolicy.mk
include device/google/gs201/wifi/qcom/BoardConfig-wifi.mk

ifneq (,$(RELEASE_ETM_IN_USERDEBUG_ENG))
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
-include device/google/common/etm/BoardUserdebugModules.mk
endif
endif
