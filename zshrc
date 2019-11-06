# シンボリックリンクで利用してください

setopt share_history
export HISTFILE=${HOME}/.zsh_history
export HISTSIZE=50000
export SAVEHIST=100000
setopt EXTENDED_HISTORY
export ZPLUG_HOME=${HOME}/.zplug
source $ZPLUG_HOME/init.zsh
fpath=(/usr/local/share/zsh-completions $fpath)

# LANG設定
export LANG=en_US.UTF-8

# pure の設定
autoload -U promptinit; promptinit

#1() プラグインを定義する
zplug 'zsh-users/zsh-autosuggestions'
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure"
zplug "b4b4r07/enhancd", use:init.sh


# (2) インストールする
if ! zplug check --verbose; then
    printf 'Install? [y/N]: '
    if read -q; then
        echo; zplug install
    fi 
fi
zplug load --verbose

# fzf関連
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
    local branch_name st branch_status

    if [ ! -e  ".git" ]; then
        # gitで管理されていないディレクトリは何も返さない
        return
    fi
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        # 全てcommitされてクリーンな状態
        branch_status="%F{green}"
    elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
        # gitに管理されていないファイルがある状態
        branch_status="%F{red}?"
    elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
        # git addされていないファイルがある状態
        branch_status="%F{red}+"
    elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
        # git commitされていないファイルがある状態
        branch_status="%F{yellow}!"
    elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
        # コンフリクトが起こった状態
        echo "%F{red}!(no branch)"
        return
    else
        # 上記以外の状態の場合は青色で表示させる
        branch_status="%F{blue}"
    fi
    # ブランチ名を色付きで表示する
    echo "${branch_status}[$branch_name]"
}

# alias

alias bexec='bundle exec'
alias ls='ls -G'

# /alias
bindkey -e

# fzfでhistory
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

# fzfのデフォルトコマンド
# alias vzv="nvim $(fzf)"

# fzfでgit add
fzf-add() {
	local selected
	selected="$(git diff --relative --name-only | fzf)"
	if [ -n "$selected" ]; then
		echo $selected
		git add $selected
	fi
}
alias fa="fzf-add"

alias sed="gsed"

# githubのプルリク画面へ移動できるコマンド
function open-github-pr() {
    export IFS='/'
    # gitリポジトリではない、また、Githubをホストにしていない場合には処理を點せたくないがうまく行ってない。
    # とりあえず仕事なので放置する.
    $(git status); if [[ $? = 128 ]]; then   echo 'Gitリポジトリではありません'; return 1; fi;
    current_branch_name=$(git branch | grep \* | sed -e 's/*//g' -e 's/^[ \t]*//g' -e 's/[ \t]*$//g')
    base_url='https://github.com'
    owner_and_repository=$(git remote -v | sed -n '1p' | sed -e 's/origin\|git@github.com\:\|\.git\|(.*//g' -e 's/^[ \t]*//g' -e 's/[ \t]*$//g')
    echo $owner_and_repository | (read owner repository; echo 'プルリクエストの新規作成画面へ移動します'; open "${base_url}/${owner}/${repository}/pull/new/${current_branch_name}")
    export IFS=' 	
'
}

alias opr='open-github-pr'
