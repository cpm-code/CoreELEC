# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="udpxy"
PKG_VERSION="93d427f0fc181837b8294db072303c3310f88b6d"
PKG_SHA256="293a7e86e185f55a573a552a21cbb4f4a26fc728f6f195f8e0fc3e134c14be38"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.udpxy.com"
PKG_URL="https://github.com/pcherenkov/udpxy/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A UDP-to-HTTP multicast traffic relay daemon."
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"

post_unpack() {
  mv ${PKG_BUILD}/README ${PKG_BUILD}/README-
  mv ${PKG_BUILD}/chipmunk/* ${PKG_BUILD}
  rmdir ${PKG_BUILD}/chipmunk
}

configure_target() {
  export CFLAGS+=" -Wno-stringop-truncation"
}
