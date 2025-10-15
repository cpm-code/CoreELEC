# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aspnet8-runtime"
PKG_VERSION="8.0.21"
PKG_LICENSE="MIT"
PKG_SITE="https://dotnet.microsoft.com/"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ASP.NET Core Runtime enables you to run existing web/server applications."
PKG_TOOLCHAIN="manual"

case "${ARCH}" in
  "aarch64")
    PKG_SHA256="87dc5e4a8573000c9fe89d6e2971c09fed063ce90172fc8b5f5fc704a56ad81b"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.21/aspnetcore-runtime-8.0.21-linux-arm64.tar.gz"
    ;;
  "arm")
    PKG_SHA256="2ce75146385e7964c6fd11f9775455ab802c700541be3acaecf74b43191502e8"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.21/aspnetcore-runtime-8.0.21-linux-arm.tar.gz"
    ;;
  "x86_64")
    PKG_SHA256="08415698df9a1c0d217a69e47f1578b458d2ae3bb4677e0281fadd0209f3745b"
    PKG_URL="https://builds.dotnet.microsoft.com/dotnet/aspnetcore/Runtime/8.0.21/aspnetcore-runtime-8.0.21-linux-x64.tar.gz"
    ;;
esac
PKG_SOURCE_NAME="aspnetcore-runtime_${PKG_VERSION}_${ARCH}.tar.gz"
