# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="valgrind"
PKG_VERSION="3.26.0"
PKG_SHA256="8d54c717029106f1644aadaf802ab9692e53d93dd015cbd19e74190eba616bd7"
PKG_LICENSE="GPL"
PKG_SITE="https://valgrind.org/"
PKG_URL="https://sourceware.org/pub/valgrind/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool to help find memory-management problems in programs"

if [ "${TARGET_ARCH}" = "arm" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only32bit"
elif [ "${TARGET_ARCH}" = "aarch64" -o "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only64bit"
fi
