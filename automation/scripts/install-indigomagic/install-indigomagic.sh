#!/usr/bin/env bash
set -e

FILE="${1:-IndigoMagic.tar.gz}"
THEME_DIR="/usr/share/themes"
TMP_DIR="$(mktemp -d)"

echo "[*] Using file: $FILE"

if [ ! -f "$FILE" ]; then
    echo "[!] File not found: $FILE"
    exit 1
fi

echo "[*] Extracting..."
case "$FILE" in
    *.tar.gz|*.tgz) tar -xzf "$FILE" -C "$TMP_DIR" ;;
    *.tar.xz)       tar -xJf "$FILE" -C "$TMP_DIR" ;;
    *.zip)          unzip -q "$FILE" -d "$TMP_DIR" ;;
    *) echo "[!] Unsupported format"; exit 1 ;;
esac

echo "[*] Searching for valid theme folders..."

# Find directories that actually look like themes
mapfile -t THEMES < <(find "$TMP_DIR" -type d \
    \( -name "gtk-2.0" -o -name "gtk-3.0" -o -name "xfwm4" \) \
    -printf '%h\n' | sort -u)

if [ ${#THEMES[@]} -eq 0 ]; then
    echo "[!] No valid theme folders found"
    echo "[DEBUG] Contents:"
    find "$TMP_DIR" -maxdepth 3
    exit 1
fi

echo "[*] Found ${#THEMES[@]} theme(s):"

for THEME_PATH in "${THEMES[@]}"; do
    THEME_NAME=$(basename "$THEME_PATH")
    echo "  → $THEME_NAME"

    echo "[*] Installing $THEME_NAME..."
    rm -rf "$THEME_DIR/$THEME_NAME"
    mv "$THEME_PATH" "$THEME_DIR/$THEME_NAME"
    chmod -R 755 "$THEME_DIR/$THEME_NAME"
done

# Apply first theme found
FIRST_THEME=$(basename "${THEMES[0]}")

echo "[*] Applying theme: $FIRST_THEME"
xfconf-query -c xsettings -p /Net/ThemeName -s "$FIRST_THEME" 2>/dev/null || true
xfconf-query -c xfwm4 -p /general/theme -s "$FIRST_THEME" 2>/dev/null || true

rm -rf "$TMP_DIR"

echo "[✓] Done. Installed ${#THEMES[@]} theme(s)."
echo "[*] If it doesn't show, log out/in."