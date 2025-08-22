#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="/root/homelab"
PVE_DIR="$REPO_DIR/proxmox"
HISTORY_FILE="$PVE_DIR/pveperf_history.md"
PVESH_TIMEOUT="3s"

mkdir -p "$PVE_DIR"

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root (use sudo)"
  exit 1
fi

TS="$(date -Iseconds)"
HOST="$(hostname -s)"

mapfile -t NODES < <(pvecm nodes | awk 'NR>1 && $1 ~ /^[0-9]+$/ {print $3}' | sed 's/\*//')

uphuman () {
  local s=${1:-0} d h m r
  d=$((s/86400)); r=$((s%86400)); h=$((r/3600)); m=$(((r%3600)/60))
  printf "%dd %dh %dm" "$d" "$h" "$m"
}

{
  echo
  echo "## $TS (collector: $HOST)"
} >> "$HISTORY_FILE"

for node in "${NODES[@]}"; do
  STATUS_JSON="$(timeout "$PVESH_TIMEOUT" pvesh get "/nodes/$node/status" --output-format=json 2>/dev/null || true)"

  if [[ -z "${STATUS_JSON// }" || "$STATUS_JSON" == "null" ]]; then
    echo "- $node: offline" >> "$HISTORY_FILE"
    continue
  fi

  # crude JSON parsing with sed (safe for simple flat keys)
  get_val() {
    echo "$STATUS_JSON" | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\([0-9.]\+\).*/\1/p" | head -n1
  }

  cpu_frac=$(get_val cpu)
  maxcpu=$(get_val maxcpu)
  uptime=$(get_val uptime)

  mem_used=$(echo "$STATUS_JSON" | sed -n 's/.*"used"[[:space:]]*:[[:space:]]*\([0-9]\+\).*"free".*/\1/p' | head -n1)
  mem_total=$(echo "$STATUS_JSON" | sed -n 's/.*"total"[[:space:]]*:[[:space:]]*\([0-9]\+\).*"free".*/\1/p' | head -n1)

  root_used=$(echo "$STATUS_JSON" | sed -n 's/.*"rootfs":[^}]*"used"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' | head -n1)
  root_total=$(echo "$STATUS_JSON" | sed -n 's/.*"rootfs":[^}]*"total"[[:space:]]*:[[:space:]]*\([0-9]\+\).*/\1/p' | head -n1)

  : "${cpu_frac:=0}" "${maxcpu:=1}" "${uptime:=0}" "${mem_used:=0}" "${mem_total:=1}" "${root_used:=0}" "${root_total:=1}"

  cpu_pct=$(awk -v c="$cpu_frac" -v m="$maxcpu" 'BEGIN{ printf "%.1f", (c/m)*100 }')
  to_gib() { awk -v b="$1" 'BEGIN{ printf "%.2f", (b/1073741824) }'; }

  mem_used_g=$(to_gib "$mem_used")
  mem_total_g=$(to_gib "$mem_total")
  root_used_g=$(to_gib "$root_used")
  root_total_g=$(to_gib "$root_total")

  echo "- $node: CPU ${cpu_pct}% | Mem ${mem_used_g}/${mem_total_g} GiB | Uptime $(uphuman "$uptime") | RootFS ${root_used_g}/${root_total_g} GiB" \
    >> "$HISTORY_FILE"
done

cd "$REPO_DIR"
git add "$HISTORY_FILE"
git diff --cached --quiet || git commit -m "auto: cluster metrics ($HOST @ $TS)"
git push || true

echo " Appended cluster metrics to $HISTORY_FILE"
