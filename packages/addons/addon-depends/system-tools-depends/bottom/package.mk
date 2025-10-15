# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bottom"
PKG_VERSION="0.11.2"
PKG_SHA256="213fbea68a315e012a0ab37e3382a287f0424675a47de04801aef4758458e64b"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/ClementTsang/bottom"
PKG_URL="https://github.com/ClementTsang/bottom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain cargo:host"
PKG_LONGDESC="A TUI system monitor written in Rust."
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
  cp ${PKG_BUILD}/.${TARGET_NAME}/target/${TARGET_NAME}/release/btm ${INSTALL}
}
