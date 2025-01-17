# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.usf"
PKG_VERSION="21.0.1-Omega"
PKG_SHA256="0fdd54cd1368a64120e3ca499aed6953f5dce38adb8420b1f0aaf3db1b7e899b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/audiodecoder.usf"
PKG_URL="https://github.com/xbmc/audiodecoder.usf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="audiodecoder.usf"
PKG_LONGDESC="audiodecoder.usf"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.audiodecoder"
PKG_ADDON_PROJECTS="any !RPi1 !Slice"
