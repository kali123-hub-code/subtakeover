#!/bin/bash

# Simple Subdomain Takeover Checker

if [ -z "$1" ]; then
  echo "Usage: $0 <target-domain>"
  exit 1
fi

TARGET="$1"
OUTDIR="subtake-output"
mkdir -p "$OUTDIR"

echo "[*] Finding subdomains for: $TARGET"
subfinder -d "$TARGET" -silent > "$OUTDIR/subdomains.txt"

echo "[*] Checking live subdomains..."
httpx -silent -status-code -follow-redirects -l "$OUTDIR/subdomains.txt" -mc 200,403,404 > "$OUTDIR/live.txt"

echo "[*] Checking for possible subdomain takeovers..."

> "$OUTDIR/vulnerable.txt"

while IFS= read -r url; do
  status_code=$(echo "$url" | awk '{print $2}')
  sub=$(echo "$url" | cut -d " " -f 1)

  # Check for common takeover indicators
  content=$(curl -s -m 10 "$sub")
  if echo "$content" | grep -qiE "NoSuchBucket|There's nothing here|This domain is not yet configured|Heroku|The request could not be satisfied|unrecognized domain|Do not have a root directory"; then
    echo "[+] Vulnerable: $sub ($status_code)" | tee -a "$OUTDIR/vulnerable.txt"
  fi
done < "$OUTDIR/live.txt"

echo "[*] Done. Results saved in $OUTDIR/vulnerable.txt"
