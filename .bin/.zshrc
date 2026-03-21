
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

# XDG Base Directory
[ -f "$HOME/.config/profile" ] && . "$HOME/.config/profile"

typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
        /usr/bin
        /bin
)

# Ctrl+Dでログアウトしてしまうことを防ぐ
#setopt IGNOREEOF

# 日本語を使用
export LANG=ja_JP.UTF-8

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

# 色を使用
autoload -Uz colors
colors

# 補完
autoload -Uz compinit
compinit

# emacsキーバインド
#bindkey -e

# 他のターミナルとヒストリーを共有
setopt share_history

# コマンド履歴を5万行保存する
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# ヒストリーに重複を表示しない
setopt histignorealldups 


# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 自動でpushdを実行
setopt auto_pushd

# pushdから重複を削除
setopt pushd_ignore_dups

# コマンドミスを修正
setopt correct

#setopt nonomatch

# グローバルエイリアス
#alias -g L='| less'
#alias -g H='| head'
#alias -g G='| grep'
#alias -g GI='| grep -ri'


###### エイリアス #####
alias lst='ls -ltr --color=auto'
alias l='ls -ltr --color=auto'
alias la='ls -la --color=auto'
alias ll='ls -l --color=auto'
alias so='source'
alias soz='source ~/.zshrc'
alias v='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
# historyに日付を表示
#alias h='fc -lt '%F %T' 1'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

# git系
alias g='git'
alias gl='git log'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gpu='git pull'
alias gpom='git pull origin master'
alias gb='git branch'
alias gco='git checkout'
alias gcm='git checkout master'
alias gcmain='git checkout main'
alias gf='git fetch'
alias gc='git commit'
alias gm='git merge'
alias gmm='git merge master'

# bundle系
alias b='bundle'
alias be='bundle exec'
alias bi='bundle install'
alias bp='bundle exec pronto run'

# docker系
# コンテナ管理：docker container(dcon)
alias d='docker'
alias dc='docker-compose'
alias dcon='docker container'

# イメージ管理：docker image(dima)
alias dima='docker image'
alias dls='docker image ls'

# kubernetes系
alias k='kubectl'
alias kcx='kubectx'
alias kns='kubens'

# backspace,deleteキーを使えるように
#stty erase ^H
#bindkey "^[[3~" delete-char

# cdの後にlsを実行
chpwd() { ls -ltr --color=auto }

# どこからでも参照できるディレクトリパス
cdpath=(~)

# 区切り文字の設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars "_-./;@"
zstyle ':zle:*' word-style unspecified

# Ctrl+sのロック, Ctrl+qのロック解除を無効にする
setopt no_flow_control

# プロンプトを2行で表示、時刻を表示
PROMPT="%(?.%{${fg[green]}%}.%{${fg[red]}%})%n${reset_color}@${fg[purple]}%m${reset_color}(%*%) %~
%# "

# 補完後、メニュー選択モードになり左右キーで移動が出来る
zstyle ':completion:*:default' menu select=2

# 補完で大文字にもマッチ
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ctrl+rでヒストリーのインクリメンタルサーチ、Ctrl+sで逆順
bindkey '^r' history-incremental-pattern-search-backward
bindkey '^s' history-incremental-pattern-search-forward

# コマンドを途中まで入力後、historyから絞り込み
# 例 ls まで打ってCtrl+pでlsコマンドをさかのぼる、Ctrl+bで逆順
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^b" history-beginning-search-forward-end

# cdrコマンドを有効 ログアウトしても有効なディレクトリ履歴
# cdr タブでリストを表示
autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs
# cdrコマンドで履歴にないディレクトリにも移動可能に
zstyle ":chpwd:*" recent-dirs-default true

# 複数ファイルのmv 例　zmv *.txt *.txt.bk
autoload -Uz zmv
alias zmv='noglob zmv -W'

# mkdirとcdを同時実行
function mkcd() {
  if [[ -d $1 ]]; then
    echo "$1 already exists!"
    cd $1
  else
    mkdir -p $1 && cd $1
  fi
}

# git設定
RPROMPT="%{${fg[purple]}%}[%~]%{${reset_color}%}"
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# AWSのリージョン設定(Tokyo)
export AWS_REGION=ap-northeast-1

export PATH="/usr/local/opt/openssl@1.0/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
# export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
# export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
eval "$(fnm env --use-on-cd)"
export PATH="/opt/homebrew/opt/lsof/bin:$PATH"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export LDFLAGS="-L/opt/homebrew/opt/readline/lib"
export PATH="/usr/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql@8.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.0/include"

# export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/mysql@8.0/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/mysql@8.0/lib"
export CPPFLAGS="-I/opt/homebrew/opt/mysql@8.0/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql@8.0/lib/pkgconfig"
export PATH="$PATH:/path/to/yarn"
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)

# Sratship : https://starship.rs/ja-JP/guide
# zshのプロンプトをStarshipでカスタマイズするために必要な初期設定
eval "$(starship init zsh)"
[[ /opt/homebrew/bin/kubectl ]] && source <(kubectl completion zsh)

# pecoの設定
peco-src () {
  local repo=$(ghq list | peco --query "$LBUFFER")
  if [ -n "$repo" ]; then
    repo=$(ghq list --full-path --exact $repo)
    BUFFER="cd ${repo}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src
peco-src () {
    local repo=$(ghq list | peco --query "$LBUFFER")
    if [ -n "$repo" ]; then
        repo=$(ghq list --full-path --exact $repo)
        BUFFER="cd ${repo}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# Config for ArgoCD
export ARGOCD_OPTS="--grpc-web"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
