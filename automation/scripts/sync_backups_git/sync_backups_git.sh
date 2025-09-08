#!/bin/bash

REPO_DIR="/root/homelab"
PVE_DIR="$REPO_DIR/proxmox"
OUT_FILE="$PVE_DIR/backup_jobs.json"
HISTORY_FILE="$PVE_DIR/backup_jobs_history.json"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)"
   exit 1
fi

echo "Exporting Proxmox backup jobs..."
BACKUP_OUTPUT=$(pvesh get /cluster/backup --output-format json-pretty 2>&1)

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

cat <<EOF > "$OUT_FILE"
{
  "host": "$HOSTNAME",
  "timestamp": "$TIMESTAMP",
  "backup_jobs": $BACKUP_OUTPUT
}
EOF

echo "Updated latest backup jobs at $OUT_FILE"

cat <<EOF >> "$HISTORY_FILE"
{
  "host": "$HOSTNAME",
  "timestamp": "$TIMESTAMP",
  "backup_jobs": $BACKUP_OUTPUT
}
EOF

echo "Appended to historical log at $HISTORY_FILE"

cd "$REPO_DIR" || exit
git add "$OUT_FILE" "$HISTORY_FILE"
git commit -m "Sync: backup jobs on $TIMESTAMP" || echo "No changes to commit."
git push

echo "Git sync complete."
exit 0
