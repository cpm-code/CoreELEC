# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020 present Team CoreELEC (https://coreelec.org)

PKG_NAME="splash-image"
PKG_VERSION="82aaea90d1845e0988371791b5e568b8122ca294"
PKG_SHA256="febccc1e6b6a7d5b79ca7e283a1c09ed965001373ce6956e7d3057aca4c92a65"
PKG_LICENSE="GPL"
PKG_SITE="https://coreelec.org"
PKG_URL="https://github.com/CoreELEC/splash-image/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_INIT="toolchain gcc:init glibc libspng zlib"
PKG_LONGDESC="Boot splash screen supporting animation by single RGBA png files"

# Splash assets are selected dynamically from the distro tree based on DEVICE.
# Include them in the stamp inputs so changing images triggers rebuilds.
PKG_NEED_UNPACK+=" ${DISTRO_DIR}/${DISTRO}/splash/${DEVICE}"

makeinstall_init() {
  mkdir -p $INSTALL/usr/bin
    cp splash-image $INSTALL/usr/bin

  mkdir -p $INSTALL/splash/progress
    # Copy by value (dereference symlinks) so the initramfs never contains
    # splash assets that are symlinks to paths that won't exist at runtime.
    find_file_path "splash/${DEVICE}/splash-*.png" && cp -L ${FOUND_PATH} $INSTALL/splash || :
    find_file_path "splash/${DEVICE}/progress/splash-*" && cp -L ${FOUND_PATH} $INSTALL/splash/progress || :
}
