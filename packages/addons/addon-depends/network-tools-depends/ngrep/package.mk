# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ngrep"
PKG_VERSION="1.48.3"
PKG_SHA256="7c69777c21cc491368b2f1fe057d1d44febcf42413a885b59badeade5264a066"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jpr5/ngrep"
PKG_URL="https://github.com/jpr5/ngrep/archive/v${PKG_VERSION}.tar.gz"
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
