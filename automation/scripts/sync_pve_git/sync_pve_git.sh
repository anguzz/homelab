#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/root/homelab"
PVE_DIR="$REPO_DIR/proxmox"
OUT_FILE="$PVE_DIR/pveperf.md"
HISTORY_FILE="$PVE_DIR/pveperf_history.md"

TS="$(date -Iseconds)"
HOST="$(hostname -s)"

mkdir -p "$PVE_DIR"

# Get nodes table
NODES_TABLE="$(pvesh get /nodes --output-format=text)"

# Markdown header
TABLE_HEADER="| Node | CPU % | Mem Used / Total (GiB) | Uptime (s) |
|------|------:|-------------------------:|-------------:|"
TABLE_ROWS=()

while read -r line; do
    [[ "$line" == node* ]] && continue  # skip header
    node=$(echo "$line" | awk '{print $1}')
    status=$(echo "$line" | awk '{print $2}')
    cpu_frac=$(echo "$line" | awk '{print $3}')
    maxcpu=$(echo "$line" | awk '{print $4}')
    mem_used=$(echo "$line" | awk '{print $5}')
    mem_total=$(echo "$line" | awk '{print $6}')
    uptime=$(echo "$line" | awk '{print $7}')

    cpu_pct=$(awk -v f="$cpu_frac" -v m="$maxcpu" 'BEGIN{printf("%.1f", (f/m)*100)}')
    mem_used_g=$(awk -v b="$mem_used" 'BEGIN{printf("%.2f", b/1073741824)}')
    mem_total_g=$(awk -v b="$mem_total" 'BEGIN{printf("%.2f", b/1073741824)}')

    TABLE_ROWS+=("| $node | $cpu_pct | $mem_used_g / $mem_total_g | $uptime |")
done <<< "$NODES_TABLE"

# Write latest snapshot
{
  echo "# Proxmox Cluster Metrics (no jq)"
  echo
  echo "**Collected by**: \`$HOST\`  "
  echo "**Timestamp**: \`$TS\`"
  echo
  echo "$TABLE_HEADER"
  for row in "${TABLE_ROWS[@]}"; do
    echo "$row"
  done
} > "$OUT_FILE"

# Append to history
{
  echo
  echo "## $TS"
  echo
  echo "$TABLE_HEADER"
  for row in "${TABLE_ROWS[@]}"; do
    echo "$row"
  done
} >> "$HISTORY_FILE"

cd "$REPO_DIR"
git add "$OUT_FILE" "$HISTORY_FILE"
git commit -m "auto: cluster metrics @ $TS" || echo "No changes to commit."
git push || true

echo "Done. Updated $OUT_FILE and appended to $HISTORY_FILE"
