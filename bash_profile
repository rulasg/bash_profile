# for Brew
# export PATH="/usr/local/bin:$PATH"
# Hides the default login message
export BASH_SILENCE_DEPRECATION_WARNING=1
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
# Enable colors in bash
export CLICOLOR=1
export LSCOLORS=GxBxCxDxexegedabagaced

## Alias

alias lla="ls -la"
alias ll="ls -l"
alias kk=kubectl
alias qq=exit
alias ep="vi ~/.bash_profile"

# get current git branch
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Variable
SET_K8_NS_ON_PROMPT = 0

# get current k8s namespave
parse_k8s_namespace(){
    #kubectl config view --minify --output 'jsonpath={..namespace}' 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    CONTEXT=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2> /dev/null)

    if [ -n "$CONTEXT" ]; then
        echo " (${CONTEXT})"
    fi
}

# change k8s current namespace
change_Namespace(){
    kubectl config set-context --current --namespace=$1
}

# https://techbloc.net/archives/3990
# export PS1="${BLUE}\W ${GREEN}\u${YELLOW}\$(__oc_ps1)${NORMAL} \$ "

# COLORS : https://en.wikipedia.org/wiki/ANSI_escape_code
NORMAL="\[\033[00m\]"
BLUE="\[\033[0;34m\]"
YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
MAGENTA="\[\033[0;35m\]"
ORANGE="\[\033[38;5;166m\]"

# find username@hostname:$ 
# export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;32m\]\$(parse_git_branch)\[\033[00m\]\$ "
#export PS1="\[\033[01;33m\]\u\[\033[00m:\[\033[38;5;166m\]\w\[\033[0;32m\]\$(parse_git_branch)\[\033[00m\]\$ "
#export PS1="\[\033[1;33m\]\u\[\033[00m:\[\033[38;5;166m\]\w${GREEN}\$(parse_git_branch)\$(parse_k8s_namespace)${NORMAL}\$ "
export PS1="${YELLOW}\u${NORMAL}: ${ORANGE}\w${GREEN}\$(parse_git_branch)${CYAN}\$(parse_k8s_namespace)${NORMAL} \$ "
eval "$(/opt/homebrew/bin/brew shellenv)"

# for bash completion
export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d"
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# Bash autocompletion
# export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
# [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
