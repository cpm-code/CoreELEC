# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmsxx"
PKG_VERSION="9c6600529d4e0f6c72bc2429728ab01617fb5349"
PKG_SHA256="254794daf263565b033d742cf35c0388c040b201be4466ce1ade3bb5c924731b"
PKG_LICENSE="MPL-2.0"
PKG_SITE="https://github.com/tomba/kmsxx"
PKG_URL="https://github.com/tomba/kmsxx/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdrm libfmt"
PKG_LONGDESC="Library and utilities for kernel mode setting"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Ddefault_library=shared \
                       -Dkmscube=false \
                       -Domap=disabled \
                       -Dpykms=disabled"
