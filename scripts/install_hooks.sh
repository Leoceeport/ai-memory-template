#!/bin/sh
# 安裝 git pre-commit 金鑰掃描（每個人 clone 後跑一次）
cd "$(dirname "$0")/.." || exit 1
cp hooks/pre-commit .git/hooks/pre-commit && chmod +x .git/hooks/pre-commit && echo "已安裝 pre-commit 金鑰掃描"
