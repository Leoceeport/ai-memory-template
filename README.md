# AI 共用記憶系統（泛用範本）

讓一個團隊裡的每個人各自跑 Claude Code（或任何會讀檔的 AI 助理），共用同一份記憶：同一套規則、同一批客戶／案子／教訓，誰做了什麼下一個人接得上。

## 它解決什麼
- AI 每次開新對話都失憶 → 記憶寫成檔案，開工先讀。
- 多人各養各的 AI，規則互相打架 → 規則只有一份主表，改動走審核佇列。
- 接力斷線 → 每件事寫「做了什麼、決定了什麼、待辦」，帶日期直寫進主題資料夾。

## 目錄
```
MEMORY.md              入口索引（每次開工必讀、只放一行一條的指針）
_org.md                組織側寫（公司是誰、做什麼、禁忌）
domains/
  _index.md            主題總索引
  rules/               規則主表、寫入規範、kind 定義
  people/              客戶、夥伴、人物識別（別名表）
  projects/            進行中的案子（一案一檔或一案一資料夾）
  lessons/             教訓、糾正、審核佇列
  tools/               工具用法、金鑰在哪、排程
scripts/
  memory_commit.sh     收尾自動 commit
.claude/
  CLAUDE.md            貼進每個人的 ~/.claude/CLAUDE.md 或專案 CLAUDE.md
```

## 讀寫規則（最重要的三條）
1. **讀**：入口索引 → 主題索引 → 具體檔，最多三次查詢。不要整包讀。
2. **寫**：動詞開頭（implemented / fixed / decided / discovered / flagged / reversed / deferred），帶日期檔名或日期段落，直寫主題資料夾並更新該資料夾的 `_index.md`。不值得寫就不寫。
3. **改規則**：任何人對 AI 的糾正先進 `domains/lessons/correction-queue.jsonl`，由管理員審過才進主表。

## 上線順序
1. 兩個人試兩週：一個管理員、一個使用者。
2. 只開三個主題：people、projects、rules。
3. 兩週後看索引有沒有被維護，有再加人。

## 同步
- 用 git：開工 `git pull`、收工 `scripts/memory_commit.sh`。
- 金鑰、密碼、個資不進倉庫；各自放本機 Keychain 或環境變數。
- 只放文字，不放大檔。

## 授權
自用與團隊內部使用皆可，改成自己的版本不需回報。
