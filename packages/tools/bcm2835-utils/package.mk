# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-utils"
PKG_VERSION="230d67ad28e74b17a42064453b2163991cb51a5e"
PKG_SHA256="4901d4b8729afb6dd7de39333311ac575d56f0a7ed92c4efd4af4b664bad4eb3"
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
