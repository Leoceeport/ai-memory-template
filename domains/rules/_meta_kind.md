# 檔案標頭 `kind` 定義與寫入規範

每個記憶檔開頭放 frontmatter：
```
---
name: 短-slug
description: 一行說明（用來判斷相關性）
type: user | feedback | project | reference
kind: decision | discovery | gotcha | correction | progress | decision_reversal | open_question
date: YYYY-MM-DD
---
```

| kind | 意思 | 例 |
|---|---|---|
| decision | 拍板了的決定 | 報價一律含稅 |
| discovery | 查到的事實 | 某供應商只收現金 |
| gotcha | 踩過的坑 | 某工具存檔會丟圖 |
| correction | 對 AI 行為的糾正 | 不要用相對時間詞 |
| progress | 進度 | 案子做到哪、待辦 |
| decision_reversal | 推翻先前決定 | 原本 A 改成 B、原因 |
| open_question | 待決 | 等老闆決定的事 |

## 寫入規範
- 動詞開頭：implemented / fixed / decided / discovered / flagged / reversed / deferred。
- 相對時間詞（昨天、剛才、上週）禁用，寫日期。
- 同一天同一件事不重寫，先 grep 有沒有。
- 不確定的事標「待驗」，不要寫成事實。
