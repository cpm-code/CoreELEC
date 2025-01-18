# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.biogenesis"
PKG_VERSION="21.0.2-Omega"
PKG_SHA256="fdd5a5abf98318e01e22c88f81ae3838b2f3b76f99b39e01fc94af528a200849"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.biogenesis"
PKG_URL="https://github.com/xbmc/screensaver.biogenesis/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.biogenesis"
PKG_LONGDESC="screensaver.biogenesis"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "${OPENGL}" = "no" ]; then
  exit 0
fi
