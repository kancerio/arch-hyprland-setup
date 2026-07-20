
---

### 2. `install.sh`

```bash
#!/bin/bash
# Скрипт для установки всего софта после базовой установки Arch

set -e  # прерывать при ошибке

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
sudo pacman -S --needed --noconfirm - < packages-repo.txt

echo "==> Установка пакетов из AUR..."
yay -S --needed --noconfirm - < packages-aur.txt

echo "==> Установка Avalonia Templates..."
dotnet new install Avalonia.Templates

echo "==> Установка Oh My Zsh и темы Powerlevel10k..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

echo "==> Установка завершена. Рекомендуется перезагрузить систему."