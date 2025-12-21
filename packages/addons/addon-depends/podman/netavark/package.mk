# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="netavark"
PKG_VERSION="1.17.1"
PKG_SHA256="22cdaea57490014c8faf029d0e2d585d9fddcfcb35fc342f812ba79b27d5d3d1"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/containers/netavark"
PKG_URL="https://github.com/containers/netavark/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cargo:host protobuf:host"
PKG_LONGDESC="Container network stack"
PKG_TOOLCHAIN="manual"

make_target() {
  cargo build \
    --target ${TARGET_NAME} \
    --release \
    --locked \
    --all-features
}

makeinstall_target() {
  mkdir -p ${INSTALL}
  cp ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/netavark ${INSTALL}
}
