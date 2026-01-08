# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="Pillow"
PKG_VERSION="12.1.0"
PKG_SHA256="8160e8b97c9e12337073b91d427d88df9490ba500f21d32015cfbb6f98846670"
PKG_LICENSE="BSD"
PKG_SITE="https://python-pillow.org/"
PKG_URL="https://github.com/python-pillow/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain pybind11:host Python3 zlib freetype libjpeg-turbo tiff"
PKG_LONGDESC="The Python Imaging Library adds image processing capabilities to your Python interpreter."
PKG_TOOLCHAIN="python"

PKG_PYTHON_OPTS_TARGET="-C--build-option=build_ext -C--build-option=--disable-platform-guessing"

post_makeinstall_target() {
  python_remove_source

  rm -rf ${INSTALL}/usr/bin
}
