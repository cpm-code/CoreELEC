# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="filebrowser"
PKG_VERSION="2.42.3"
PKG_REV="6"
PKG_LICENSE="Apache License 2.0"
PKG_SITE="https://filebrowser.org"
PKG_DEPENDS_TARGET="toolchain:host"
PKG_SECTION="service"
PKG_SHORTDESC="Filebrowser: a web based filemanger"
PKG_LONGDESC="Filebrowser (${PKG_VERSION}): is a web based file managing interface and it can be used to upload, delete, preview, rename and edit your files."
PKG_TAR_STRIP_COMPONENTS="no"
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="89719297eb42cecea42bf6462dbd30b94270715b2438af48ee64ef9e2ba0ae52"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-arm64-filebrowser.tar.gz"
    ;;
  "arm")
    PKG_SHA256="325304e6e556c492fc0c671a9ea58feb81f52ccf6b6caba7b386c097e12fdb3c"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-armv7-filebrowser.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="f304368af024c32e33f8d36e123f5ec5e4d0264601f32493e7f6c26d2f4018ef"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-amd64-filebrowser.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="filebrowser-${PKG_VERSION}-${ARCH}.tar.gz"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Web File Browser"
PKG_ADDON_PROJECTS="any !RPi1"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  cp -r ${PKG_BUILD}/filebrowser ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
}
