#!/bin/sh
# Claude Code SessionStart hook：開工自動把入口索引與主題總索引注入對話（stdout 會進入 context）。
# 安裝方式見 .claude/settings.snippet.json；MEMORY_REPO 改成你放倉庫的路徑。
REPO="${MEMORY_REPO:-$HOME/memory}"
[ -d "$REPO" ] || { echo "（記憶倉庫不存在：$REPO）"; exit 0; }
cd "$REPO" && git pull --rebase -q origin "$(git rev-parse --abbrev-ref HEAD)" 2>/dev/null
echo "## 共用記憶（開工必讀，路徑 $REPO）"
echo; cat "$REPO/MEMORY.md"; echo
echo "## 主題總索引"; echo; cat "$REPO/domains/_index.md"
echo; echo "規則：讀 → 入口索引 → 主題索引 → 具體檔，最多三次查詢。收工寫回對應主題檔並更新索引，再跑 scripts/memory_commit.sh。"
