# 每月整理（防索引腐爛；管理員做，約 30 分鐘）

1. 跑 `scripts/check_index.sh`，修掉壞連結、補漏編索引的檔。
2. 每個主題資料夾：
   - 同一件事有兩個檔 → 合併成一個，舊的刪除或搬進 `_archive/`。
   - `kind: progress` 且案子已結 → 濃縮成三行結論，搬進 `_archive/`。
   - `kind: open_question` 已有答案 → 改成 decision，補日期。
   - `decision_reversal` 存在時，確認被推翻的舊 decision 已標記「已被 X 推翻」。
3. 主題索引超過 60 條就拆子資料夾或歸檔；入口索引 `MEMORY.md` 永遠只放指針，不超過一頁。
4. 糾正佇列（多人團隊才有）：逐條 y / n / edit，通過的合併進規則主表，佇列清空。
5. 跑 `scripts/scan_secrets.sh --all`，確認沒有金鑰。
6. `scripts/memory_commit.sh` 推送；在 `domains/lessons/` 留一行「YYYY-MM-DD 月整理完成：合併 N、歸檔 M」。

歸檔慣例：各主題資料夾下 `_archive/YYYYMM/`，原檔搬過去，索引改指向摘要。
