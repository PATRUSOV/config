#!/bin/bash

# Проверяем количество аргументов
if [ $# -lt 2 ]; then
    echo "Ошибка: Необходимо указать 2 аргумента" >&2
    echo "Использование: $0 <имя_процесса> <команда_запуска>" >&2
    echo "Пример для wofi: $0 wofi 'wofi --show drun'" >&2
    echo "Пример для wlogout: $0 wlogout 'wlogout --protocol layer-shell'" >&2
    exit 1
fi

APP_NAME="$1"
APP_CMD="$2"

# Проверяем, что команда содержит имя процесса
if ! grep -qw "$APP_NAME" <<< "$APP_CMD"; then
    echo "Ошибка: Команда запуска должна содержать имя процесса '$APP_NAME'" >&2
    exit 1
fi

# Основная логика
if pgrep -x "$APP_NAME" > /dev/null; then
    pkill -x "$APP_NAME"
else
    if ! command -v "$APP_NAME" > /dev/null; then
        echo "Ошибка: Программа '$APP_NAME' не установлена" >&2
        exit 1
    fi
    eval "$APP_CMD"
fi