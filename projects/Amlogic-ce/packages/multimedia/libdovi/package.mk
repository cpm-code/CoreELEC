# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Team CoreELEC (https://coreelec.org)

PKG_NAME="libdovi"
PKG_VERSION="3ec01dccbf5a74dfc7c58e3864029187b715344f"
PKG_SITE="https://github.com/quietvoid/dovi_tool"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHA256="9483c81af5ca34ad8081ee71b0c31bdb92114d29bdcb664774ede4071c3fcea2"
PKG_URL="https://github.com/quietvoid/dovi_tool/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET+=" cargo:host cbindgen:host"
PKG_LICENSE="MIT"
PKG_LONGDESC="dovi_tool is a CLI tool combining multiple utilities for working with Dolby Vision."
PKG_TOOLCHAIN="manual"

pre_make_target() {
  CARGO_CRATE_DIR="${PKG_BUILD}/dolby_vision"
  CARGO_TARGET="${TARGET_NAME}"
  CARGO_TARGET_DIR_NAME="${TARGET_NAME}"
  CARGO_STATICLIB="${PKG_BUILD}/.${TARGET_NAME}/target/${CARGO_TARGET_DIR_NAME}/release/libdolby_vision.a"
  CARGO_HEADER="${PKG_BUILD}/.${TARGET_NAME}/target/${CARGO_TARGET_DIR_NAME}/release/rpu_parser.h"
  CARGO_PKG_VERSION="$(sed -n 's/^version = "\(.*\)"/\1/p' ${CARGO_CRATE_DIR}/Cargo.toml | head -n 1)"
  CARGO_FETCH_OPTS="--manifest-path ${CARGO_CRATE_DIR}/Cargo.toml \
                    --target ${CARGO_TARGET}"
  CARGO_BASE_OPTS="--manifest-path ${CARGO_CRATE_DIR}/Cargo.toml \
                   --target ${CARGO_TARGET} \
                   --features capi"
  CARGO_BUILD_OPTS="--lib \
                    --profile release \
                    ${CARGO_BASE_OPTS}"

  if ! grep -q '^crate-type = ' ${CARGO_CRATE_DIR}/Cargo.toml; then
    sed -i '/^\[lib\]$/a crate-type = ["rlib", "staticlib"]' ${CARGO_CRATE_DIR}/Cargo.toml
  fi
}

make_target() {
  cargo fetch ${CARGO_FETCH_OPTS}
  cargo build ${CARGO_BUILD_OPTS}
  ${TOOLCHAIN}/bin/cbindgen ${CARGO_CRATE_DIR} \
    --config ${CARGO_CRATE_DIR}/cbindgen.toml \
    --crate dolby_vision \
    --output ${CARGO_HEADER}
}

makeinstall_target() {
  for destdir in ${SYSROOT_PREFIX} ${INSTALL}; do
    mkdir -p ${destdir}/usr/include/libdovi ${destdir}/usr/lib/pkgconfig

    cp ${CARGO_STATICLIB} ${destdir}/usr/lib/libdovi.a
    cp ${CARGO_HEADER} ${destdir}/usr/include/libdovi/rpu_parser.h

    cat >${destdir}/usr/lib/pkgconfig/dovi.pc <<EOF
prefix=/usr
exec_prefix=${prefix}
libdir=${exec_prefix}/lib
includedir=${prefix}/include

Name: dovi
Description: Dolby Vision metadata parsing and writing library
Version: ${CARGO_PKG_VERSION}
Libs: -L${libdir} -ldovi
Cflags: -I${includedir}
EOF
  done
}
