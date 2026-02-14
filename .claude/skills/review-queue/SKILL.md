---
name: review-queue
description: 自分にレビュー依頼が来ているPRを一覧表示し、優先度とサマリをつける
allowed-tools: Bash(gh *)
---

# Review Queue

自分にレビュー依頼が来ているPRを一覧し、優先度付きで表示する。

## 対象リポジトリ

`repos.txt`（このSKILL.mdと同じディレクトリ）に記載されたリポジトリのみを対象とする。
リポジトリを追加・削除したい場合は `repos.txt` を編集すること。

## ステップ1: レビュー待ちPRの取得

まず `repos.txt` を読み込み、記載されたリポジトリごとに `--repo` フラグを組み立てて検索する：

```bash
gh search prs --review-requested=@me --state=open --repo <repo1> --repo <repo2> ... --json repository,number,title,author,createdAt,url,isDraft --limit 30
```

取得結果から以下を除外する：
- **Draft PR**: `isDraft` が `true` のもの
- **作成から1年以上経過**: `createdAt` が現在から365日以上前のもの

フィルタ後にPRが0件の場合: 「レビュー待ちのPRはありません 🎉」と表示して終了する。

## ステップ2: 各PRの規模を把握

各PRについて以下を実行し、変更規模を取得する：

```bash
gh pr view <number> -R <owner/repo> --json additions,deletions,changedFiles,labels
```

## ステップ3: 優先度の判定

以下の基準で各PRに優先度をつける：

### 🔴 High（先にレビューすべき）
- 変更行数が少ない（additions + deletions ≤ 50）… すぐ終わるので先に片付ける
- ラベルに urgent, hotfix, critical, bug 等が含まれる
- 作成から2営業日以上経過している

### 🟡 Medium
- 変更行数が中程度（51〜300行）
- 作成から1営業日以上経過

### 🟢 Low
- 変更行数が多い（300行超）… まとまった時間を確保して取り組む
- 作成当日

## ステップ4: 出力

以下のフォーマットで出力する。優先度 High → Medium → Low の順に並べる。

````markdown
## 📋 レビューキュー（全 N 件）

### 🔴 High
| PR | リポジトリ | Author | 規模 | 経過 | 概要 |
|----|-----------|--------|------|------|------|
| [#123 タイトル](URL) | repo名 | author | +20/-5 (2files) | 3日 | 一言サマリ |

### 🟡 Medium
| PR | リポジトリ | Author | 規模 | 経過 | 概要 |
|----|-----------|--------|------|------|------|
| ... | ... | ... | ... | ... | ... |

### 🟢 Low
| PR | リポジトリ | Author | 規模 | 経過 | 概要 |
|----|-----------|--------|------|------|------|
| ... | ... | ... | ... | ... | ... |

---
💡 詳細を見るには `/review-summary <URL>` → フルレビューは `/review-pr <URL>`
````

各PRの「概要」は、PRのタイトルとラベルから1行で推測する。diffは読まない（高速化のため）。
