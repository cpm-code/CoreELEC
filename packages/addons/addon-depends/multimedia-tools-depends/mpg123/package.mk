# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpg123"
PKG_VERSION="1.33.3"
PKG_SHA256="6a0c6472dd156e213c2068f40115ebbb73978c2d873e66bae2a250e2d2198d26"
PKG_LICENSE="LGPLv2"
PKG_SITE="https://www.mpg123.org/"
PKG_URL="https://downloads.sourceforge.net/sourceforge/mpg123/mpg123-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="A console based real time MPEG Audio Player for Layer 1, 2 and 3."
PKG_BUILD_FLAGS="-sysroot +pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static"
