#!/bin/bash
set -euo pipefail

DISK="${1:-}"

if [[ -z "$DISK" ]]; then
  echo "Usage: $0 /dev/nvme0n1"
  exit 1
fi

if [[ ! -b "$DISK" ]]; then
  echo "ERROR: $DISK はブロックデバイスではありません"
  exit 1
fi

echo "Checking disk: $DISK"
echo

# ===== 1. GPT か確認 =====
if ! sgdisk -p "$DISK" >/dev/null 2>&1; then
  echo "ERROR: GPT ディスクではありません"
  exit 1
fi
echo "✓ GPT detected"

# ===== 2. 期待する構成 =====
declare -A EXPECTED=(
  [ARCH_EFI]=ef00
  [ARCH-ROOT]=8300
  [swap]=8200
)

# ===== 3. 実際のパーティション取得 =====
mapfile -t PARTS < <(
  lsblk -rpno NAME,PARTLABEL,PARTTYPE "$DISK" | grep -v "^$DISK "
)

if [[ ${#PARTS[@]} -eq 0 ]]; then
  echo "ERROR: パーティションが見つかりません"
  exit 1
fi

STATUS=0

echo
echo "Partition check:"
echo "-----------------------------------------"

for LABEL in "${!EXPECTED[@]}"; do
  FOUND=false
  EXPECTED_TYPE="${EXPECTED[$LABEL]}"

  for LINE in "${PARTS[@]}"; do
    read -r NAME PARTLABEL PARTTYPE <<< "$LINE"

    if [[ "$PARTLABEL" == "$LABEL" ]]; then
      FOUND=true

      # PARTTYPE は UUID → 先頭 4 桁で比較
      TYPE_SHORT="${PARTTYPE:0:4}"

      if [[ "$TYPE_SHORT" == "$EXPECTED_TYPE" ]]; then
        echo "✓ $LABEL ($NAME) type=$TYPE_SHORT"
      else
        echo "✗ $LABEL ($NAME) type=$TYPE_SHORT (expected $EXPECTED_TYPE)"
        STATUS=1
      fi
    fi
  done

  if ! $FOUND; then
    echo "✗ $LABEL が見つかりません"
    STATUS=1
  fi
done

echo "-----------------------------------------"

if [[ $STATUS -eq 0 ]]; then
  echo "OK: パーティション構成は正しいです"
else
  echo "NG: パーティション構成に問題があります"
fi

exit $STATUS

