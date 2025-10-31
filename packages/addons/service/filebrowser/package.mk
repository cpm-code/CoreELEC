# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="filebrowser"
PKG_VERSION="2.44.2"
PKG_REV="0"
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
    PKG_SHA256="bfd8a552642e3d1782df59fdc373cfd1d343b3e8d3d04ea6393104d6ed54e5e5"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-arm64-filebrowser.tar.gz"
    ;;
  "arm")
    PKG_SHA256="c003ed63a3123f1e68813e95a0af3a178d38974d246b01f3d315a6714c462b76"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-armv7-filebrowser.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="908c3dd9c12602aac0aa4f81bd133a87b5ba808267e88148c415b7639312057e"
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
