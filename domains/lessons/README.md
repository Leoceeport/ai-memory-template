# 糾正佇列格式

每行一個 JSON：
```
{"id":"corr-<時間戳>","timestamp":"2026-01-01T10:00:00+08:00","by":"誰","scene":"發生什麼","wrong":"錯在哪","correct":"該怎麼做","category":"verification|approval|language|persona|tone|factcheck","priority":"core|rule|nit","pinned":false}
```
流程：AI 或使用者追加到 `correction-queue.jsonl` → 管理員逐條回 y / n / edit → 通過的搬到 `corrections.jsonl` 並合併進規則主表 → 清空佇列。
