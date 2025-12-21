# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libwebsockets"
PKG_VERSION="4.5.2"
PKG_SHA256="04244efb7a6438c8c6bfc79b21214db5950f72c9cf57e980af57ca321aae87b2"
PKG_LICENSE="MIT"
PKG_SITE="https://libwebsockets.org"
PKG_URL="https://github.com/warmcat/libwebsockets/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl json-c libuv"
PKG_LONGDESC="Library for implementing network protocols with a tiny footprint."

PKG_CMAKE_OPTS_TARGET="-DLWS_WITH_LIBUV=ON \
                       -DLWS_WITHOUT_TESTAPPS=ON"
