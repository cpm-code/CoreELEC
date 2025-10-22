# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-utils"
PKG_VERSION="c3d0bfe3a8fc3404bebf2fe149b1bf595ee0f30b"
PKG_SHA256="10a36f19bd9d25aa267fc68c35cc56956312c19fdcc05f57459bb0a5f9c0561a"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/raspberrypi/utils"
PKG_URL="https://github.com/raspberrypi/utils/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="cmake:host gcc:host dtc"
PKG_LONGDESC="Raspberry Pi related collection of scripts and simple applications"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/vclog/vclog ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/dtmerge/{dtoverlay,dtmerge,dtparam} ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/pinctrl/pinctrl ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/vcgencmd/vcgencmd ${INSTALL}/usr/bin
  cp -PRv ${PKG_BUILD}/.${TARGET_NAME}/vcmailbox/vcmailbox ${INSTALL}/usr/bin
}
