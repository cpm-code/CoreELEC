# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="double-conversion"
PKG_VERSION="3.3.1"
PKG_SHA256="fe54901055c71302dcdc5c3ccbe265a6c191978f3761ce1414d0895d6b0ea90e"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/google/double-conversion"
PKG_URL="https://github.com/google/double-conversion/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Efficient binary-decimal and decimal-binary conversion routines for IEEE doubles."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="-sysroot"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
                       -DBUILD_SHARED_LIBS=ON \
                       -DBUILD_TESTING=OFF"
