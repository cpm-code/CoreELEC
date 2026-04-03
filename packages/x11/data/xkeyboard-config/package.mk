# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xkeyboard-config"
PKG_VERSION="2.47"
PKG_SHA256="e59984416a72d58b46a52bfec1b1361aa7d84354628227ee2783626c7a6db6b6"
PKG_LICENSE="MIT"
PKG_SITE="https://www.X.org"
PKG_URL="https://www.x.org/releases/individual/data/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="X keyboard extension data files."

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_DEPENDS_TARGET+=" xkbcomp"
  fi
}

pre_configure_target() {
  PKG_MESON_OPTS_TARGET="-Dcompat-rules=true"

  if [ "${DISPLAYSERVER}" = "x11" ]; then
    PKG_MESON_OPTS_TARGET+=" -Dxorg-rules-symlinks=true"
  else
    PKG_MESON_OPTS_TARGET+=" -Dxorg-rules-symlinks=false"
  fi
}

post_makeinstall_target() {
  local install_root

  for install_root in "${SYSROOT_PREFIX}" "${INSTALL}"; do
    rm -rf "${install_root}/usr/share/X11/xkb"
    mkdir -p "${install_root}/usr/share/X11"
    cp -a "${install_root}/usr/share/xkeyboard-config-2" "${install_root}/usr/share/X11/xkb"
  done
}
