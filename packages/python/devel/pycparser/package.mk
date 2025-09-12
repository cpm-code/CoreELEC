# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pycparser"
PKG_VERSION="2.23"
PKG_SHA256="78816d4f24add8f10a06d6f05b4d424ad9e96cfebf68a4ddc99c65c0720d00c2"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://pypi.org/project/pycparser/"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host setuptools:host"
PKG_LONGDESC="Complete C99 parser in pure Python"
PKG_TOOLCHAIN="python"
