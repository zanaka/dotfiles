---
name: review-summary
description: PRの要約を素早く出す。フルレビュー前のトリアージ用。
allowed-tools: Bash(gh *)
---

# Review Summary（トリアージ用）

PRの概要を素早く把握するためのライトなサマリを出す。フルレビュー（`/review-pr`）の前段として使う。

## ステップ1: レビュー対象のPRを特定

引数の有無で対象PRを判別すること。

### 引数ありの場合
`$ARGUMENTS` をPR番号またはURLとしてそのまま使用する。

### 引数なしの場合
カレントブランチに紐づくPRを自動検出する：

```bash
gh pr view --json number,title,url
```

- PRが見つからなかった場合: 「カレントブランチに紐づくPRが見つかりませんでした。`/review-summary <URL>` のように指定してください。」と表示して終了する。

## ステップ2: 情報取得

以下を**並列で**実行する：

```bash
gh pr view <PR> --json title,body,author,createdAt,additions,deletions,changedFiles,labels,url
gh pr diff <PR> --name-only
```

## ステップ3: 出力

取得した情報をもとに、以下のフォーマットで**簡潔に**出力する。diffの中身は読まない。

````markdown
## ⚡ [PRタイトル]

| 項目 | 値 |
|------|-----|
| Author | @author |
| 規模 | +X/-Y (Nファイル) |
| 作成日 | YYYY-MM-DD（N日前） |

### 何をしているPRか
PRのタイトルとbodyから1-2文で要約。

### 変更ファイル
変更ファイル一覧を表示。ファイル数が10を超える場合はディレクトリ単位でグルーピングする。

### レビュー時に見るべきポイント
変更ファイルの種類・規模から推測される注目ポイントを1-3個箇条書き。

### 推定レビュー時間
変更規模から推定（〜5分 / 〜15分 / 〜30分 / 30分超）

---
🔍 フルレビュー → `/review-pr <URL>`
````

**重要: このスキルは速度重視。diffの中身は絶対に読まないこと。**
