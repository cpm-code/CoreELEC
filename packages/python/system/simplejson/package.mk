# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="simplejson"
PKG_VERSION="3.20.2"
PKG_SHA256="5fe7a6ce14d1c300d80d08695b7f7e633de6cd72c80644021874d985b3393649"
PKG_LICENSE="OSS"
PKG_SITE="http://pypi.org/project/simplejson"
PKG_URL="https://files.pythonhosted.org/packages/source/${PKG_NAME:0:1}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 setuptools:host"
PKG_LONGDESC="A simple, fast, complete, correct and extensible JSON encoder and decoder for Python 2.5+."
PKG_TOOLCHAIN="python"

post_makeinstall_target() {
  python_remove_source

  rm -rf ${INSTALL}/usr/lib/python*/site-packages/*/tests
}
