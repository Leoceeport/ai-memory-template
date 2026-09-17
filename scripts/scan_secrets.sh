#!/bin/sh
# 金鑰掃描：給 pre-commit 用（掃暫存區），也可手動掃全倉：scripts/scan_secrets.sh --all
cd "$(dirname "$0")/.." || exit 1
PAT='(AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9_-]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{30,}|[0-9]{8,10}:[A-Za-z0-9_-]{35}|-----BEGIN [A-Z ]*PRIVATE KEY-----|(password|passwd|secret|token|api[_-]?key)[[:space:]]*[:=][[:space:]]*["'"'"']?[A-Za-z0-9_/+-]{12,})'
if [ "$1" = "--all" ]; then
  hits=$(grep -rnE "$PAT" --exclude-dir=.git --exclude=scan_secrets.sh . 2>&1)
else
  files=$(git diff --cached --name-only --diff-filter=ACM | grep -v 'scan_secrets.sh$')
  hits=""
  for f in $files; do
    [ -f "$f" ] || continue
    h=$(git show ":$f" | grep -nE "$PAT" 2>&1) && hits="$hits
$f:$h"
  done
fi
hits=$(printf '%s' "$hits" | sed '/^$/d')
if [ -n "$hits" ]; then
  echo "❌ 疑似金鑰／密碼，已擋下："; echo "$hits" | cut -c1-120
  echo "   確定是誤判就把該行改寫（例如只寫「金鑰在 Keychain 的 xxx」），不要繞過。"
  exit 1
fi
[ "$1" = "--all" ] && echo "全倉沒有疑似金鑰"
exit 0
