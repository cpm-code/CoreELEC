# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pypackaging"
PKG_VERSION="26.0"
PKG_SHA256="00243ae351a257117b6a241061796684b084ed1c516a08c48a3f7e147a9d80b4"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/build/"
PKG_URL="https://files.pythonhosted.org/packages/source/p/packaging/packaging-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="packaging-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyinstaller:host"
PKG_LONGDESC="Reusable core utilities for various Python Packaging interoperability specifications."
PKG_TOOLCHAIN="python-flit"
