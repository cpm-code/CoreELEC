# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ngrep"
PKG_VERSION="e918f6be8484d42da62bb9ab3539cda9a5327091"
PKG_SHA256="00cebc0257459d6003e5b0c6a9c3511bb5a205ecb67f7344e1c0ba1e63b95646"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jpr5/ngrep"
PKG_URL="https://github.com/jpr5/ngrep/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap pcre2"
PKG_LONGDESC="A tool like GNU grep applied to the network layer."
PKG_BUILD_FLAGS="-sysroot -parallel -cfg-libs"

PKG_CONFIGURE_OPTS_TARGET="--with-pcap-includes=${SYSROOT_PREFIX}/usr/include \
                           --enable-ipv6 \
                           --enable-pcre2 \
                           --disable-dropprivs"

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}
