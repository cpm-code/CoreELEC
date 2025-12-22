# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glew"
PKG_VERSION="2.3.0"
PKG_SHA256="b261a06dfc8b970e0a1974488530e58dd2390acf68acb05b45235cd6fb17a086"
PKG_LICENSE="BSD"
PKG_SITE="http://glew.sourceforge.net/"
PKG_URL="${SOURCEFORGE_SRC}/glew/glew/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain libX11"
PKG_LONGDESC="A cross-platform C/C++ extension loading library."

make_target() {
  make CC="${CC}" LD="${CC}" AR="${AR}" \
       POPT="${CFLAGS}" LDFLAGS.EXTRA="${LDFLAGS}" \
       GLEW_DEST="/usr" LIBDIR="/usr/lib" lib/libGLEW.a glew.pc
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp -PR lib/libGLEW.a ${SYSROOT_PREFIX}/usr/lib

  mkdir -p ${SYSROOT_PREFIX}/usr/lib/pkgconfig
    cp -PR glew.pc ${SYSROOT_PREFIX}/usr/lib/pkgconfig

  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -PR include/GL ${SYSROOT_PREFIX}/usr/include
}
