# dotfiles

## 旧環境Macbookからライブラリを書き出す
brew bundle dump --global --force

ファイルの中身を確認する
cat ~/.Brewfile

gitにアップ

brew install

brew コマンド：プログラム
cask コマンド：アプリケーション


### brew.sh
Macに必要なコマンドツールやデスクトップアプリをインストールする
brew bundle —-globalコマンドにより.Brewfileが読み込まれて一括で実施できる
brew コマンド：プログラム
cask コマンド：アプリケーション


## Homebrew
### Formula
The package definition


### Cask
An extension of homebrew to install macOS native apps
/Applications/MacDown.app/Contents/SharedSupport/bin/ma

### Tap
A Git repository of Formula and/or commands
brew公式以外のパッケージのことで、brew tapでGitHubにあるパッケージをそのままインストールするコマンド

### Brewfile
$ brew bundle dump