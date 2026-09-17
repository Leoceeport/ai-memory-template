#!/bin/sh
# Claude Code Stop hook：每天第一次發現記憶倉庫有未提交變更時，擋一次收尾、提醒寫回與提交；之後不再擋（避免無限迴圈）。
REPO="${MEMORY_REPO:-$HOME/memory}"
input=$(cat)
echo "$input" | grep -q '"stop_hook_active": *true' && exit 0
[ -d "$REPO/.git" ] || exit 0
mark="/tmp/memory_stop_nudge_$(date +%F)"
[ -e "$mark" ] && exit 0
cd "$REPO" || exit 0
if [ -n "$(git status --porcelain)" ]; then
  touch "$mark"
  printf '{"decision":"block","reason":"記憶倉庫有未提交的變更。收尾前確認：(1) 這次做的事、決定、待辦已寫進對應主題檔 (2) 該資料夾 _index.md 已更新 (3) 跑 scripts/check_index.sh 與 scripts/memory_commit.sh。做完再結束。"}\n'
fi
exit 0
