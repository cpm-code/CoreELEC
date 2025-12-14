# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hatchling"
PKG_VERSION="1.16.2"
PKG_SHA256="ce130f1e7b91f562c61932289146575e253e47affb2e018eb81fa6f9fcb08c4b"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/pypa/hatch"
PKG_URL="https://github.com/pypa/hatch/archive/refs/tags/hatch-v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="pluggy:host python-pathspec:host trove-classifiers:host"
PKG_LONGDESC="Modern, extensible Python project management"
PKG_TOOLCHAIN="python"

pre_configure_host() {
  cd backend
}
