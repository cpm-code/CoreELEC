# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgpiod"
PKG_VERSION="2.2"
PKG_SHA256="ae35329db7027c740e90c883baf27c26311f0614e6a7b115771b28188b992aec"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/about/"
PKG_URL="https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/snapshot/libgpiod-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 distutilscross:host"
PKG_LONGDESC="Tools for interacting with the linux GPIO character device."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-tools --disable-shared"

post_make_target() {
  (
    export PYTHONXCPREFIX="${SYSROOT_PREFIX}/usr"
    export LDFLAGS+=" -L${PKG_BUILD}/.${TARGET_NAME}/lib/.libs"
    export LDSHARED="${CC} -shared"
    export CFLAGS+=" -fcommon -I${PKG_BUILD}/include"
    export CPPFLAGS="${TARGET_CPPFLAGS} -I${SYSROOT_PREFIX}/usr/include/${PKG_PYTHON_VERSION}"
    cd ../bindings/python
    python3 setup.py build
  )
}
