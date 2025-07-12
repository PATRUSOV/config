#!/bin/bash

# Проверка аргумента
if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/wallpaper.jpg"
    exit 1
fi

WALLPAPER="$1"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"
HYPRPAPER_SOCKET="/run/user/1000/hypr/"*"/.hyprpaper.sock"

# Проверка файла
if [ ! -f "$WALLPAPER" ]; then
    echo "Error: File '$WALLPAPER' not found!"
    exit 1
fi

# Создаём папку для конфига
mkdir -p "$(dirname "$CONFIG_FILE")"

# Обновляем конфиг
echo "preload = $WALLPAPER" > "$CONFIG_FILE"
echo "wallpaper = ,$WALLPAPER" >> "$CONFIG_FILE"

# Проверяем, запущен ли hyprpaper
if ! ls $HYPRPAPER_SOCKET 2>/dev/null; then
    echo "Starting hyprpaper..."
    nohup hyprpaper > /dev/null 2>&1 &
    sleep 0.5  # Даём время на запуск
fi

# Меняем обои
hyprctl hyprpaper unload all
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"

echo "Wallpaper changed to: $WALLPAPER (saved in config)"