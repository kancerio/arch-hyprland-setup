#!/bin/bash
# Восстанавливает конфиги из папки configs/ в ~/.config

if [ -d "configs/.config" ]; then
    echo "==> Копирование конфигов..."
    cp -r configs/.config/* ~/.config/
    echo "Конфиги восстановлены."
else
    echo "Папка configs/.config не найдена. Пропускаем."
fi