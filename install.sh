# Update Arch Linux
sudo pacman -Syu

# Install various packages
sudo pacman -S zed-editor flatpak reflector pacman-contrib

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

# Install flatpak packages
flatpak install --user flathub md.obsidian.Obsidian
flatpak override --user --socket=wayland md.obsidian.Obsidian

# Install mise-en-place
curl https://mise.run | sh

# Stow the dotfiles
stow .

# Use raw commands instead of stow, because of hard links
systemctl --user add-wants niri.service mako.service
systemctl --user add-wants niri.service waybar.service
systemctl --user add-wants niri.service swaybg.service
