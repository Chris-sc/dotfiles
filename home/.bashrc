
# ~/.bashrc

# -----------------------
# Only run if interactive
# -----------------------
[[ $- != *i* ]] && return

# -----------------------
# Color support
# -----------------------
export TERM=xterm-256color
export LS_OPTIONS='-A --color=auto --group-directories-first'
eval "$(dircolors)"

alias ls='ls $LS_OPTIONS'
alias ll='ls -lah'
alias la='ls -A'

alias ls='eza --icons=always --color=always --no-user --group-directories-first'
alias ll='eza -lgh --icons=always --no-user --group-directories-first'
alias la='eza -la --icons=always --no-user --group-directories-first'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# -----------------------
# Editor
# -----------------------
export EDITOR=nvim
export VISUAL=nvim
alias vim='nvim'

# -----------------------
# Language / locale
# -----------------------
export LANG=en_US.UTF-8

# -----------------------
# FZF integration (if installed)
# -----------------------
if [ -f /usr/share/fzf/key-bindings.bash ]; then
    source /usr/share/fzf/key-bindings.bash
fi

if [ -f /usr/share/fzf/completion.bash ]; then
    source /usr/share/fzf/completion.bash
fi

# -----------------------
# Git-aware prompt
# -----------------------
# Colors: readable on dark backgrounds
GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
YELLOW="\[\e[0;33m\]"
MAGENTA="\[\e[0;35m\]"
RESET="\[\e[0m\]"

# Show user@host, cwd, git branch
parse_git_branch() {
    git branch 2>/dev/null | sed -n '/\* /s///p'
}

PS1='\[\033[33m\]\w\[\033[0m\]$(git branch --show-current 2>/dev/null | awk "{print \" (\033[35m\" \$1 \"\033[0m)\"}")\n\$ '

# -----------------------
# History settings
# -----------------------
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


# -----------------------
# Aliases for convenience
# -----------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

alias cat='bat'

export LESS='-R'
export MANPAGER="less -R"
# Enable colored man pages
export LESS_TERMCAP_mb=$'\e[1;31m'   # bold red
export LESS_TERMCAP_md=$'\e[1;32m'   # bold green
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m' # standout bg
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[04;36m'   # underline cyan

# -----------------------
# Aliases
# -----------------------
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
