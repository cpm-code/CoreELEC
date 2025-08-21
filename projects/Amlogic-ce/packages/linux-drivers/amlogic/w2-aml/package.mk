# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team CoreELEC (https://coreelec.org)

PKG_NAME="w2-aml"
PKG_VERSION="18dcc012d1520a9d67f57a16db4fb816dcedbf2e"
PKG_SHA256="b51438ba3a90aa65bea1b2b64cb440935a7393b7b9ea72ae80e757521c993a04"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/CoreELEC/w2-aml"
PKG_URL="https://github.com/CoreELEC/w2-aml/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Amlogic W2 Linux driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  kernel_make -C $(kernel_path) M=${PKG_BUILD}/aml_drv \
    CONFIG_ANDROID_GKI=y
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    find ${PKG_BUILD}/aml_drv/ -name \*.ko -not -path '*/\.*' -exec cp {} ${INSTALL}/$(get_full_module_dir)/${PKG_NAME} \;

  mkdir -p ${INSTALL}/$(get_full_firmware_dir)
    cp ${PKG_BUILD}/common/aml_w2_*.txt ${INSTALL}/$(get_full_firmware_dir)
    cp ${PKG_BUILD}/common/wifi_w2_*sdio.bin ${INSTALL}/$(get_full_firmware_dir)
}
