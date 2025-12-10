# Update Arch Linux
sudo pacman -Syu

# Install various packages
sudo pacman -S zed-editor flatpak reflector pacman-contrib stow python-pycryptodomex

# Install `yay`
sudo pacman -S --needed base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

# Install `librewolf`
# NOTE: Do not install through `flatpak` in order to take advantage of Firefox's native sandbox features
yay -S librewolf-bin

# Install `brave`
# NOTE: Do not install through `flatpak` in order to take advantage of Chromium's native sandbox features
yay -S brave-bin

# Install `localsend`
yay -S localsend-bin

# Install flatpak packages
flatpak install --user flathub md.obsidian.Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian

# Install yt-dlp
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O ~/.local/bin/yt-dlp
chmod a+rx ~/.local/bin/yt-dlp
mkdir -p ~/.config/yt-dlp/plugins
git clone https://github.com/Blu-Tiger/StreamingCommunity-yt-dlp-plugin.git ~/.config/yt-dlp/plugins/StreamingCommunity-yt-dlp-plugin

# Setup printers
sudo pacman -S cups ghostscript
yay -S kyocera-ecosys-p5021cdw
sudo systemctl enable cups
sudo systemctl start cups
# Setup thorugh http://localhost:631/ (search ppd file in /usr/share/ppd)

# Install mise-en-place
curl https://mise.run | sh

# Stow the dotfiles
stow .

# Use raw commands instead of stow, because of hard links
systemctl --user add-wants niri.service mako.service
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaybg.service

# Web apps copied from https://github.com/basecamp/omarchy/blob/adc506f053f2b553a93f37e3628ae3b48fffe75e/default/bash/functions#L19
web2app() {
  if [ "$#" -ne 3 ]; then
    echo "Usage: web2app <AppName> <AppURL> <IconURL> (IconURL must be in PNG -- use https://dashboardicons.com)"
    return 1
  fi

  local APP_NAME="$1"
  local APP_URL="$2"
  local ICON_URL="$3"
  local ICON_DIR="$HOME/.local/share/applications/icons"
  local DESKTOP_FILE="$HOME/.local/share/applications/${APP_NAME}.desktop"
  local ICON_PATH="${ICON_DIR}/${APP_NAME}.png"

  mkdir -p "$ICON_DIR"

  if ! curl -sL -o "$ICON_PATH" "$ICON_URL"; then
    echo "Error: Failed to download icon."
    return 1
  fi

  cat > "$DESKTOP_FILE" <<EOF
  [Desktop Entry]
  Version=1.0
  Name=$APP_NAME
  Comment=$APP_NAME
  Exec=librewolf --new-window "$APP_URL"
  Terminal=false
  Type=Application
  Icon=$ICON_PATH
  StartupNotify=true
EOF

  chmod +x "$DESKTOP_FILE"
}

# Install YouTube Music
web2app "YouTube Music" "https://music.youtube.com/" "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/youtube-music.png"
