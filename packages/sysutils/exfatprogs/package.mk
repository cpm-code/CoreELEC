# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="exfatprogs"
PKG_VERSION="1.3.0"
PKG_SHA256="11135e5f5320935cc0623b0d394417e667edb827d04b953680f1bbffc575045f"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/exfatprogs/exfatprogs"
PKG_URL="https://github.com/exfatprogs/exfatprogs/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="userspace utilities that contain all of the standard utilities for creating and fixing and debugging exfat filesystems."
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/share
}
