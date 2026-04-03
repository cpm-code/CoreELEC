# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2022-present Team CoreELEC (https://coreelec.org)

PKG_NAME="bash"
PKG_VERSION="5.2.37"
PKG_SHA256="9599b22ecd1d5787ad7d3b7bf0c59f312b3396d1e281175dd1f8a4014da621ff"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/bash/"
PKG_URL="https://ftp.gnu.org/gnu/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses readline"
PKG_LONGDESC="Bash is the GNU Project shell - the Bourne Again SHell."

pre_configure_target() {
  CFLAGS+=" -std=gnu17"
}

PKG_CONFIGURE_OPTS_TARGET="--with-curses \
                           --without-bash-malloc \
                           --with-installed-readline \
                             bash_cv_getcwd_malloc=yes \
                             bash_cv_printf_a_format=yes \
                             bash_cv_func_sigsetjmp=present \
                             bash_cv_sys_named_pipes=present"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp bash  ${INSTALL}/usr/bin
}

post_makeinstall_target() {
  ln -sf bash ${INSTALL}/usr/bin/sh
}
