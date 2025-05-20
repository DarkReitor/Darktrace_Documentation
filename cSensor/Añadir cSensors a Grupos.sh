#!/bin/bash

# Define el archivo que contiene los UUIDs
UUID_FILE="uuids.txt"

# Verifica si el archivo existe
if [[ ! -f "$UUID_FILE" ]]; then
    echo "El archivo $UUID_FILE no existe."
    exit 1
fi

# GID constante (ID del grupo)
GID=8

# Lee cada línea del archivo (cada línea es un UUID)
while IFS= read -r UUID; do
    # Verifica que el UUID no esté vacío
    if [[ -n "$UUID" ]]; then
        echo "Procesando UUID: $UUID"

        # Realiza la solicitud cURL
        curl -k 'https://dt-nadon-eis.sofistic.soc/agh/api/v1/device_group_members' \
          -H 'accept: text/plain, */*; q=0.01' \
          -H 'accept-language: es-419,es;q=0.9,en;q=0.8' \
          -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' \
          -H 'cookie: tz=; connect.sid=s%3AohQp3WIrkMvOkaWMlUinT1bC8bNK9W8-.GhjKnORLe0bqNP2JD7%2FtGEXY8%2BdI26%2FSjiXs%2BxWlimk' \
          -H 'origin: https://dt-nadon-eis.sofistic.soc' \
          -H 'priority: u=1, i' \
          -H 'referer: https://dt-nadon-eis.sofistic.soc/csensor' \
          -H 'sec-ch-ua: "Chromium";v="128", "Not;A=Brand";v="24", "Google Chrome";v="128"' \
          -H 'sec-ch-ua-mobile: ?0' \
          -H 'sec-ch-ua-platform: "Windows"' \
          -H 'sec-fetch-dest: empty' \
          -H 'sec-fetch-mode: cors' \
          -H 'sec-fetch-site: same-origin' \
          -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36' \
          -H 'x-requested-with: XMLHttpRequest' \
          -H 'x-xsrf-token: OxZQEVBk-7D2rjWwTxYOhypuDodhoBL5IuJ8' \
          --data-raw "{\"aghuuid\":\"$UUID\",\"gid\":$GID}"

        echo -e "\n"
    fi
done < "$UUID_FILE"
