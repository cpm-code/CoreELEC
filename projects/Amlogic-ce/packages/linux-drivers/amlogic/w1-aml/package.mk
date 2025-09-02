# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team CoreELEC (https://coreelec.org)

PKG_NAME="w1-aml"
PKG_VERSION="57b5c4e92856ac76f4bb1c6b3ff2adbf19b1c75a"
PKG_SHA256="12c5c2c84632ad8a96fcb89a832a201947e372944a32b3249fcf82ec2cfbeee2"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/CoreELEC/w1-aml"
PKG_URL="https://github.com/CoreELEC/w1-aml/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Amlogic W150S1 Linux driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  if [ "${TARGET_KERNEL_ARCH}" = "arm" ]; then
    kernel_make -C $(kernel_path) M=${PKG_BUILD}/project_w1/vmac
  else
    ccflags="-mno-outline-atomics
             -Wno-unused-variable
             -Wno-unused-but-set-variable
             -Wno-strict-prototypes"

    kernel_make -C $(kernel_path) M=${PKG_BUILD}/project_w1/vmac \
      subdir-ccflags-y="${ccflags}"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    find ${PKG_BUILD}/project_w1/vmac/ -name \*.ko -not -path '*/\.*' -exec cp {} ${INSTALL}/$(get_full_module_dir)/${PKG_NAME} \;

  mkdir -p ${INSTALL}/$(get_full_firmware_dir)/w1
    cp ${PKG_BUILD}/project_w1/vmac/aml_wifi*.txt ${INSTALL}/$(get_full_firmware_dir)/w1
}
