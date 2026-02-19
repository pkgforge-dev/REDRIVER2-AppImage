#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor      \
    libjpeg-turbo \
    sdl2          \
    openal        \
    premake5
    
echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Making nightly build of REDRIVER2..."
echo "---------------------------------------------------------------"
REPO="https://github.com/OpenDriver2/REDRIVER2"
VERSION="$(git ls-remote "$REPO" HEAD | cut -c 1-9 | head -1)"
git clone --branch develop-SoapyMan --single-branch --recursive --depth 1 "$REPO" ./REDRIVER2
echo "$VERSION" > ~/version

mkdir -p ./AppDir/bin
cd ./REDRIVER2/src_rebuild
premake5 gmake2
