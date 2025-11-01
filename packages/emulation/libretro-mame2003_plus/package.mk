# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2003_plus"
PKG_VERSION="870e8ba3fa4e6635e2eb9d85c939589498659c32"
PKG_SHA256="1240e641302ec7941d4879c88e162afae3a7347b67e8b0f2c826f70b23ea5166"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="https://github.com/libretro/mame2003-plus-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2003_plus_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2003_PLUS_LIB"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="ARCH= CC=${CC} NATIVE_CC=${CC} LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" >${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake

  mkdir -p ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus
  cp -v metadata/mame2003-plus.xml ${SYSROOT_PREFIX}/usr/share/libretro-database/mame2003-plus/

  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples
  cp -rv metadata/artwork ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  cp -v metadata/{cheat,hiscore,history}.dat ${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus
  # something must be in a folder in order to include it in the image, so why not some instructions
  echo "Put your samples here." >${SYSROOT_PREFIX}/usr/share/retroarch/system/mame2003-plus/samples/readme.txt
}
