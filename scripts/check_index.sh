#!/bin/sh
# 索引健檢：列出 (1) 沒進索引的檔 (2) 索引指到不存在的檔 (3) 入口索引壞連結 (4) 索引過長警告。
# 用法：scripts/check_index.sh   ；回傳非 0 表示有問題。
cd "$(dirname "$0")/.." || exit 1
bad=0
for idx in domains/_index.md domains/*/_index.md; do
  dir=$(dirname "$idx")
  # (2) 索引指到不存在的檔
  grep -o '](\([^)]*\))' "$idx" | sed 's/](\(.*\))/\1/' | grep -v '^http' | while read -r link; do
    [ -e "$dir/$link" ] || echo "壞連結  $idx → $link"
  done
  # (1) 沒進索引的檔（只看同層 .md，排除索引本身與 README）
  for f in "$dir"/*.md; do
    b=$(basename "$f")
    case "$b" in _index.md|README.md) continue;; esac
    grep -q "$b" "$idx" || echo "未編索引  $f"
  done
  # (4) 索引過長
  n=$(grep -c '^- ' "$idx"); [ "$n" -gt 60 ] && echo "過長  $idx 有 $n 條，該歸檔或拆分"
done | tee /tmp/check_index_out
[ -s /tmp/check_index_out ] && bad=1
# (3) 入口索引壞連結
grep -o '`[^`]*/[^`]*\.md`' MEMORY.md | tr -d '`' | while read -r p; do [ -e "$p" ] || echo "入口壞連結  MEMORY.md → $p"; done | tee /tmp/check_index_out2
[ -s /tmp/check_index_out2 ] && bad=1
[ "$bad" -eq 0 ] && echo "索引正常"
exit $bad
