# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="filebrowser"
PKG_VERSION="2.49.0"
PKG_REV="5"
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
    PKG_SHA256="3832f8082af6307ffef885d29f788210575b9f397392a678c547c9753a1fbba9"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-arm64-filebrowser.tar.gz"
    ;;
  "arm")
    PKG_SHA256="dc03dae0b4c181c29f8956d32bd641400667b26b2183e3b0ef2861ba1b44a730"
    PKG_URL="https://github.com/filebrowser/filebrowser/releases/download/v${PKG_VERSION}/linux-armv7-filebrowser.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="9f45cf12a0409f28e552db8b19d54a935f0e35f58576524405966c4eeed1d7c4"
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
