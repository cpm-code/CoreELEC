# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pybuild"
PKG_VERSION="1.4.0"
PKG_SHA256="f1b91b925aa322be454f8330c6fb48b465da993d1e7e7e6fa35027ec49f3c936"
PKG_LICENSE="BSD"
PKG_SITE="https://pypi.org/project/build/"
PKG_URL="https://files.pythonhosted.org/packages/source/b/build/build-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="build-${PKG_VERSION}"
PKG_DEPENDS_HOST="flit:host pyproject-hooks:host pyinstaller:host pypackaging:host"
PKG_LONGDESC="A simple, correct Python build frontend."
PKG_TOOLCHAIN="python-flit"
