set -e

echo "==> Обновление системы и установка базовых пакетов..."
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm git base-devel wget curl

echo "==> Установка Yay (AUR-хелпер)..."
if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
else
    echo "Yay уже установлен."
fi

echo "==> Установка пакетов из официальных репозиториев..."
sudo pacman -S --needed --noconfirm \
    base-devel git wget curl \
    gcc gdb make cmake \
    dotnet-sdk \
    python python-pip python-virtualenv \
    nodejs npm \
    hyprland waybar wofi kitty thunar hyprpaper \
    nwg-dock-hyprland wlogout \
    nvidia-open-dkms nvidia-utils lib32-nvidia-utils nvidia-settings \
    linux-headers \
    networkmanager dhcpcd \
    openssh htop btop neovim vim zsh \
    ttf-jetbrains-mono-nerd ttf-dejavu ttf-liberation \
    pavucontrol scilab octave maxima wxmaxima jupyter-notebook \
    freecad qgis blender \
    firefox telegram-desktop discord steam \
    libreoffice-fresh

echo "==> Установка пакетов из AUR..."
yay -S --needed --noconfirm \
    visual-studio-code-bin \
    pycharm-community-edition \
    webstorm \
    smath \
    fritzing \
    onlyoffice-bin \
    wps-office \
    arduino-ide-bin \
    grimblast \
    headsetcontrol \
    swaync \
    penguins-eggs

echo "==> Установка Avalonia Templates..."
dotnet new install Avalonia.Templates

echo "==> Установка Oh My Zsh и темы Powerlevel10k..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

echo "==> Установка завершена. Рекомендуется перезагрузить систему."
