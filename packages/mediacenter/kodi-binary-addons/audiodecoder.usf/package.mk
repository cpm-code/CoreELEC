# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="audiodecoder.usf"
PKG_VERSION="21.0.2-Omega"
PKG_SHA256="2322f1f1dbe03fa35a0a452e849033aac5f58b598907ac5c73dd64a56c4df74c"
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
