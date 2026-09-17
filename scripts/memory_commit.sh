#!/bin/sh
# 收尾時執行：把記憶倉庫的變更 commit 並推上遠端。
set -e
cd "$(dirname "$0")/.."
git add -A
if git diff --cached --quiet; then echo "沒有變更"; exit 0; fi
git commit -q -m "memory: $(date '+%Y-%m-%d %H:%M') $(whoami)"
git pull --rebase -q 2>/dev/null || true
git push -q 2>/dev/null && echo "已推送" || echo "已 commit（沒有遠端或推送失敗）"
