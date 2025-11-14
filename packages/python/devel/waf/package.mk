# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.1.8"
PKG_SHA256="d9a2bf04957c509e6316a285754025f468af2e3d69a9a1a14874815c2cc6e049"
PKG_LICENSE="MIT"
PKG_SITE="https://waf.io"
PKG_URL="https://waf.io/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_LONGDESC="The Waf build system"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  cp -pf ${PKG_BUILD}/waf ${TOOLCHAIN}/bin/
}
