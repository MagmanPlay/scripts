#!/bin/bash

# Путь к директории ноды
DIR="/opt/remnanode"
FILE="$DIR/docker-compose.yml"

echo "Начинаем работу в $DIR..."

if [ ! -d "$DIR" ]; then
    echo "Ошибка: Директория $DIR не найдена!"
    exit 1
fi

cd "$DIR" || exit 1

# Проверяем, есть ли уже NET_ADMIN в конфиге
if grep -q "NET_ADMIN" "$FILE"; then
    echo "[OK] Параметр NET_ADMIN уже присутствует. Пропускаем редактирование YAML."
else
    echo "[WAIT] Добавляем cap_add: NET_ADMIN в $FILE..."
    # Используем sed для вставки строк сразу после 'image:'. 
    # В YAML критичны отступы: 4 пробела для cap_add:, 6 пробелов для - NET_ADMIN
    sed -i '/image:/a \    cap_add:\n      - NET_ADMIN' "$FILE"
    echo "[OK] Параметры добавлены."
fi
