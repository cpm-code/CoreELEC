# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="amlogic-boot-fip"
PKG_LICENSE="nonfree"
PKG_VERSION="f5cf6a7a78bad9d42d44293d5f2b8e2140cf2e2f"
PKG_SHA256="0f1f86cdd0d34e269597c80ddaff18144a81a07caf2a065c60bdb8d042ce6291"
PKG_SITE="https://github.com/LibreELEC/amlogic-boot-fip"
PKG_URL="https://github.com/LibreELEC/amlogic-boot-fip/archive/${PKG_VERSION}.tar.gz"
PKG_LONGDESC="Firmware Image Package (FIP) sources used to sign Amlogic u-boot binaries in LibreELEC images"
PKG_TOOLCHAIN="manual"
PKG_STAMP="${UBOOT_SYSTEM}"

post_unpack() {
  # rename dirs for alta/solitude
  mv ${PKG_BUILD}/aml-a311d-cc ${PKG_BUILD}/alta
  mv ${PKG_BUILD}/aml-s905d3-cc ${PKG_BUILD}/solitude
}
