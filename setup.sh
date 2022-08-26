#!/usr/bin/env bash

set -e

if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Update repos
add-apt-repository ppa:kelleyk/emacs
apt update

# Install emacs with native compilation
apt install emacs28-nativecomp

# Install doom emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs /home/$real_user/.emacs.d
/home/$real_user/.emacs.d/bin/doom install

# Copy the configurations
cp -r doom-emacs/* /home/$real_user/.doom.d/
cp .bash* /home/$real_user/

git submodule update --init
gpd-peda-pwndbg-gef/install.sh

# Install deps (these also include emacs deps - sorry)
apt install -y git libgpg-error-dev libassuan-dev lbzip2 autoconf automake autotools-dev bsd-mailx build-essential diffstat gnutls-dev imagemagick libasound2-dev libc6-dev libdatrie-dev libdbus-1-dev libgconf2-dev libgif-dev libgnutls28-dev libgpm-dev libgtk2.0-dev libgtk-3-dev libice-dev libjpeg-dev liblockfile-dev liblqr-1-0 libm17n-dev libmagickwand-dev libncurses5-dev libncurses-dev libotf-dev libpng-dev librsvg2-dev libsm-dev libthai-dev libtiff5-dev libtiff-dev libtinfo-dev libtool  libx11-dev libxext-dev libxi-dev libxml2-dev libxmu-dev libxmuu-dev libxpm-dev libxrandr-dev libxt-dev libxtst-dev libxv-dev quilt sharutils texinfo xaw3dg xaw3dg-dev xorg-dev xutils-dev zlib1g-dev libjansson-dev libxaw7-dev libselinux1-dev libmagick++-dev libacl1-dev

# build pinentry-emacs
cd /home/$real_user
wget https://gnupg.org/ftp/gcrypt/pinentry/pinentry-1.1.0.tar.bz2
tar -xf pinentry-1.1.0.tar.bz2
cd pinentry-1.1.0
./configure --enable-pinentry-emacs --enable-inside-emacs
make
make install
cd /home/$real_user
rm -rf pinentry-1.1.0 pinentry-1.1.0.tar.bz2

echo "pinentry-program /usr/local/bin/pinentry-emacs" > ~/.gnupg/gpg-agent.conf
