#!/bin/sh
# 收尾時執行：commit → 拉遠端（rebase）→ push。任何一步失敗都明講，不吞錯誤。
# 用法：scripts/memory_commit.sh            （也可排 cron 每日跑）
cd "$(dirname "$0")/.." || exit 1
git add -A
if git diff --cached --quiet; then
  echo "沒有變更"
else
  git commit -q -m "memory: $(date '+%Y-%m-%d %H:%M') $(whoami)" || { echo "❌ commit 失敗"; exit 1; }
  echo "已 commit $(git rev-parse --short HEAD)"
fi
if ! git remote get-url origin >/dev/null 2>&1; then
  echo "（沒有遠端，只有本機版本）"; exit 0
fi
if ! git pull --rebase -q origin "$(git rev-parse --abbrev-ref HEAD)" 2>/tmp/memory_pull_err; then
  git rebase --abort 2>/dev/null
  echo "❌ 與遠端合併衝突，已退回合併前狀態（本機 commit 保留、尚未推送）。"
  echo "   請手動處理：git pull --rebase，解衝突後 git push。錯誤："; head -3 /tmp/memory_pull_err
  exit 2
fi
if git push -q origin HEAD 2>/tmp/memory_push_err; then
  echo "已推送"
else
  echo "❌ 推送失敗（本機 commit 保留）："; head -3 /tmp/memory_push_err; exit 3
fi
