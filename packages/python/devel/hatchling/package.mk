# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hatchling"
PKG_VERSION="1.16.3"
PKG_SHA256="5949c6b35786e9fcc75668bb02a4d1d242951e4b84403e98a0be02010c0277dd"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/pypa/hatch"
PKG_URL="https://github.com/pypa/hatch/archive/refs/tags/hatch-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="pluggy:host python-pathspec:host trove-classifiers:host"
PKG_LONGDESC="Modern, extensible Python project management"
PKG_TOOLCHAIN="python"

pre_configure_host() {
  cd backend
}
