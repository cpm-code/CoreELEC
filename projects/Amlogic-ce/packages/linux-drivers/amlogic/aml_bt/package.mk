# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team CoreELEC (https://coreelec.org)

PKG_NAME="aml_bt"
PKG_VERSION="710c8112a41b228c4519a232d04633ad8ec634ce"
PKG_SHA256=""
PKG_ARCH="aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/CoreELEC/aml_bt"
PKG_URL="https://github.com/CoreELEC/aml_bt/archive/${PKG_VERSION}.tar.gz"
PKG_USETOKEN="yes"
PKG_DEPENDS_TARGET="toolchain linux w1-aml w2-aml"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Amlogic bt Linux driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  echo
  echo "build aml_hciattach"
  make -C aml_bt/aml_hciattach

  echo
  echo "build sdio_driver_bt"
  kernel_make -C ${PKG_BUILD}/aml_bt/sdio_driver_bt \
    M=${PKG_BUILD}/aml_bt/sdio_driver_bt \
    KERNEL_SRC=$(kernel_path)
    
  echo
  echo "build w2"
  kernel_make -C ${PKG_BUILD}/aml_bt/w2 \
    M=${PKG_BUILD}/aml_bt/w2 \
    KERNEL_SRC=$(kernel_path) \
    EXTRA_SYMBOLS_USB_PATH=$(get_build_dir w2-aml)/aml_drv/Module.symvers
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    install -m 0755 ${PKG_BUILD}/aml_bt/aml_hciattach/aml_hciattach ${INSTALL}/usr/sbin/aml_hciattach

  mkdir -p ${INSTALL}/$(get_full_module_dir)/aml
    find ${PKG_BUILD}/aml_bt/ -name \*.ko -not -path '*/\.*' -exec cp {} ${INSTALL}/$(get_full_module_dir)/aml \;

  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/aml
    cp ${PKG_BUILD}/aml_bt/aml_hciattach/aml_bt.conf ${INSTALL}/$(get_full_firmware_dir)/aml
    cp ${PKG_BUILD}/aml_bt/firmware/w1_bt_fw_*.bin ${INSTALL}/$(get_full_firmware_dir)/aml
    cp ${PKG_BUILD}/aml_bt/firmware/w2_bt_fw_*.bin ${INSTALL}/$(get_full_firmware_dir)/aml
}
