# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="p8-platform"
PKG_VERSION="ba6a67e5767457c45f69088b83101d77e4f143e7"
PKG_SHA256="ed6b56e5b336e744ce45eead89f16401baa097a92d1c15472e78abc151bfdb4a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/xbmc/platform/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Platform support library used by libCEC and binary add-ons for Kodi"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_INSTALL_LIBDIR:STRING=lib \
                       -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=${SYSROOT_PREFIX}/usr \
                       -DBUILD_SHARED_LIBS=0"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr
}
