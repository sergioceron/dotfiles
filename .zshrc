HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
#setopt notify
#unsetopt beep nomatch
setopt autocd

autoload -Uz compinit
autoload -U colors && colors
compinit

# End of lines added by compinstall

#eval `dircolors`

# PS1 and PS2
export PS1="%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_bold[blue]%}%1~%{$reset_color%} $ "
#export PS1="%{$fg_bold[green]%}%n%{$reset_color%}@%{$fg_bold[green]%}%m%{$reset_color%} %{$fg_bold[blue]%}%1~%{$reset_color%} $ "
export PS2="%{$fg[blue]%}$%{$reset_color%}"

# Vars used later on by zsh
export EDITOR=vim

# allow approximate
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# cd not select parent dir. 
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#Keybindings
bindkey -v
typeset -g -A key
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char 
bindkey '^R' history-incremental-search-backward
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line


#alias ls='ls --color=auto'
alias dir='ls -l'
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias poweroff="sudo /sbin/halt"
alias halt="sudo /sbin/halt"
alias reboot="sudo /sbin/reboot"
alias shutdown="sudo /sbin/shutdown"
alias umount="sudo /sbin/umount"
alias htop="sudo /usr/local/bin/htop"
alias vimro="vim -R"

# custom env vars
alias please="sudo"
alias mkworkenv="work; mkvirtualenv --system-site-packages $@"

function hist() {
    egrep $1 ~/.histfile;
}

function work {
    # sets up virtualenv project path for work stuff directory. adds 
    # in a little reminder tag too.
    while [ ! -d "$_WORK_PROJECT_HOME/siq" ]; do
        mount-work
    done
    if [ "$_WORK_ENV_ENABLED" -ne 1 ]; then
        function dework {
            if [ -n "$VIRTUAL_ENV" ]; then
                deactivate
            fi
            if [ -n "$_PREV_PROJECT_HOME" ]; then
                export PROJECT_HOME=$_PREV_PROJECT_HOME
            fi
            if [ -n "$_PREV_PS1" ]; then
                export PS1=$_PREV_PS1
            fi
            if [ -n "$_PREV_NON_WORK_PATH" ]; then
                export PATH=$_PREV_NON_WORK_PATH
            fi
            export _WORK_ENV_ENABLED=0
        }
        export _PREV_PROJECT_HOME=$PROJECT_HOME
        export PROJECT_HOME=$_WORK_PROJECT_HOME
        export _PREV_PS1=$PS1
        export PS1="[work]$PS1"
        export _WORK_ENV_ENABLED=1
        export _PREV_NON_WORK_PATH=$PATH
        export PATH=$_WORK_BIN_PATH:$PATH
    fi
    if [ -n "$1" ]; then
        workon $1
    else 
        cd "$_WORK_PROJECT_HOME"
    fi
}

function siqrefresh() {
    workdir=`pwd`

    while [ ! -d "$_WORK_PROJECT_HOME/siq" ]; do
        mount-work
    done

    for proj; do
        cd "$_WORK_PROJECT_HOME/siq/$proj"
        echo "Performing 'git pull -rebase' on $proj..."
        git pull --rebase
    done
    cd "$workdir"
}

function siq() {
    work siq; 
    if [ -n "$1" ]; then
        cd $1
    fi
    settitle ${PWD##*/};
}
function _siq() { _files -W $_WORK_PROJECT_HOME/siq; }
compdef _siq siq

function settitle() {
    if [ -n "$TMUX" ]; then
        printf "\033k$1\033\\"
    fi
}

function ssh() {
    export _OLD_TERM=$TERM
    cd $HOME
    settitle "$*"
    if [ -n "$TMUX" ]; then
        export TERM=xterm-256color
    fi
    command ssh "$@"
    export TERM=$_OLD_TERM
    settitle ${PWD##*/}
}

function nukepyc() {
    find . -name \*.pyc
    find . -name \*.pyc -delete
}

settitle ${PWD##*/}

fortune -e
