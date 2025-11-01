# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="1.5.2"
PKG_SHA256="cce88ebcffd3f790bde49caa75f97b9cc2dd54ca8f57e38c62707266ec71bc4e"
PKG_LICENSE="BSD"
PKG_SITE="https://www.videolan.org/projects/dav1d.html"
PKG_URL="https://downloads.videolan.org/pub/videolan/dav1d/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Denable_examples=false \
                       -Denable_tests=false \
                       -Denable_tools=false \
                       -Dtestdata_tests=false"
