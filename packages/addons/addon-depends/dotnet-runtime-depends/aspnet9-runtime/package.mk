# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet9-runtime"
PKG_VERSION="9.0.10"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="e7e06ffc3711f4b2bf30813b6c1717055d20ca82ee042fa9bf05a5a0bcd4a7e3"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.10/aspnetcore-runtime-9.0.10-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="bdb26d093dbfb60772eefa6c9ff16da30acd791bb1f510dac0c48a10ec5ceb94"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.10/aspnetcore-runtime-9.0.10-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="7fd7fd9da1259212c9423d561b059fa45b21bcbcc8e94da15dcca9fa73d71984"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/9.0.10/aspnetcore-runtime-9.0.10-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
