#!/usr/bin/env bash

set -e

# Install emacs
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install emacs28-nativecomp

# Install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Copy the configurations
cp -r doom-emacs/* ~/.doom.d/
cp .bash* ~

git submodule update --init
gpd-peda-pwndbg-gef/install.sh

# Install deps (these also include emacs deps - sorry)
sudo apt update && sudo apt install -y git libgpg-error-dev libassuan-dev lbzip2 autoconf automake autotools-dev bsd-mailx build-essential diffstat gnutls-dev imagemagick libasound2-dev libc6-dev libdatrie-dev libdbus-1-dev libgconf2-dev libgif-dev libgnutls28-dev libgpm-dev libgtk2.0-dev libgtk-3-dev libice-dev libjpeg-dev liblockfile-dev liblqr-1-0 libm17n-dev libmagickwand-dev libncurses5-dev libncurses-dev libotf-dev libpng-dev librsvg2-dev libsm-dev libthai-dev libtiff5-dev libtiff-dev libtinfo-dev libtool  libx11-dev libxext-dev libxi-dev libxml2-dev libxmu-dev libxmuu-dev libxpm-dev libxrandr-dev libxt-dev libxtst-dev libxv-dev quilt sharutils texinfo xaw3dg xaw3dg-dev xorg-dev xutils-dev zlib1g-dev libjansson-dev libxaw7-dev libselinux1-dev libmagick++-dev libacl1-dev

# build pinentry-emacs
cd ~
wget https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2
tar -xf pinentry-1.1.0.tar.bz2
cd pinentry-1.1.0
./configure --enable-pinentry-emacs --enable-inside-emacs
make
sudo make install
cd ~
rm -rf pinentry-1.1.0 pinentry-1.1.0.tar.bz2

echo "pinentry-program /usr/local/bin/pinentry-emacs" > ~/.gnupg/gpg-agent.conf
