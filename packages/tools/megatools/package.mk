# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team CoreELEC (https://coreelec.org)

PKG_NAME="megatools"
PKG_VERSION="1.11.5.20250706"
PKG_SHA256="51f78a03748a64b1066ce28a2ca75d98dbef5f00fe9789dc894827f9a913b362"
PKG_LICENSE="GPL"
PKG_SITE="https://packages.gentoo.org/packages/net-misc/megatools"
PKG_URL="https://xff.cz/megatools/builds/megatools-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib openssl curl"
PKG_LONGDESC="Megatools is a collection of programs for accessing Mega.nz service from a command line of your desktop or server."
PKG_TOOLCHAIN="meson"
PKG_MESON_OPTS_TARGET="-Dman=false"
