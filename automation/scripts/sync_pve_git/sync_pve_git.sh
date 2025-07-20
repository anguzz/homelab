#!/bin/bash

REPO_DIR="/root/homelab"
PVE_DIR="$REPO_DIR/proxmox"
OUT_FILE="$PVE_DIR/pveperf.md"
HISTORY_FILE="$PVE_DIR/pveperf_history.md"

# Require root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (use sudo)" 
   exit 1
fi

echo "Running pveperf..."
PVE_OUTPUT=$(pveperf 2>&1)

TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
HOSTNAME=$(hostname)

# Markdown format for latest result
cat <<EOF > "$OUT_FILE"
# pveperf Results

**Host**: \`$HOSTNAME\`  
**Timestamp**: \`$TIMESTAMP\`

\`\`\`
$PVE_OUTPUT
\`\`\`
EOF

echo "Updated latest pveperf results at $OUT_FILE"

# Append historical entry
cat <<EOF >> "$HISTORY_FILE"

## $TIMESTAMP - $HOSTNAME

\`\`\`
$PVE_OUTPUT
\`\`\`
EOF

echo "Appended to historical log at $HISTORY_FILE"

# Git sync
cd "$REPO_DIR"
git add "$OUT_FILE" "$HISTORY_FILE"
git commit -m "Sync: pveperf results on $TIMESTAMP" || echo "No changes to commit."
git push

echo "Git sync complete."
exit 0
