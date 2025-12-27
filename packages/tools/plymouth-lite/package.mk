# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="plymouth-lite"
PKG_VERSION="0.6.0-5"
PKG_SHA256="476816c34bb75715b3709a7ed0d29d93e63624858f1803e5746dc350b6081607"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/sailfishos/plymouth-lite"
PKG_URL="https://github.com/sailfishos/plymouth-lite/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_INIT="toolchain gcc:init libpng"
PKG_LONGDESC="Boot splash screen based on Fedora's Plymouth code"

pre_configure_init() {
  # plymouth-lite dont support to build in subdirs
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}-init
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/bin
    cp ply-image ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/splash
    find_file_path splash/splash.conf && cp ${FOUND_PATH} ${INSTALL}/splash
    find_file_path "splash/splash-*.png" && cp ${FOUND_PATH} ${INSTALL}/splash
}
