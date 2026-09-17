# 共用記憶系統（貼進 ~/.claude/CLAUDE.md，路徑改成你放倉庫的位置）

記憶倉庫在 `<REPO_PATH>`。
- 開工：先讀 `<REPO_PATH>/MEMORY.md`，再按需讀 `domains/<主題>/_index.md`，最多三次查詢。
- 收工：把做了什麼／決定了什麼／待辦寫進對應主題檔（動詞開頭、帶日期），更新該資料夾 `_index.md`，然後跑 `<REPO_PATH>/scripts/check_index.sh` 與 `<REPO_PATH>/scripts/memory_commit.sh`。
- 規則以 `domains/rules/rules_summary.md` 為準；要改規則先追加到 `domains/lessons/correction-queue.jsonl`。
- 金鑰、密碼、個資不寫進倉庫。
