# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tmux"
PKG_VERSION="3.6"
PKG_SHA256="136db80cfbfba617a103401f52874e7c64927986b65b1b700350b6058ad69607"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/tmux/tmux/wiki"
PKG_URL="https://github.com/tmux/tmux/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libevent ncurses"
PKG_LONGDESC="tmux is a terminal multiplexer"
PKG_BUILD_FLAGS="-sysroot"
