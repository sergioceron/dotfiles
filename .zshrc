HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#setopt notify
#unsetopt beep nomatch
setopt autocd

autoload -Uz compinit
compinit

# End of lines added by compinstall

eval `dircolors`

# PS1 and PS2
#export PS1="$(print '%{\e[1;32m%}%n@%{\e[0m%}')$(print '%{\e[1;32m%}%M%{\e[0m%}') $(print '%{\e[1;34m%}%d $ %{\e[0m%}')"
export PS1="$(print '%{\e[1;32m%}%n@%m%{\e[0m%}') $(print '%{\e[1;34m%}%1~%{\e[0m%}') $ "
export PS2="$(print '%{\e[0;34m%}$%{\e[0m%}')"

# Vars used later on by zsh
export EDITOR=vim
export BROWSER=firefox
export XTERM=urxvt

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


alias ls='ls --color=auto'
alias dir='ls -l'
alias hist="grep '$1' ~/.histfile"
alias startx="startx; exit"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias pacman="sudo pacman"
alias netcfg2="sudo netcfg2"
alias netcfg-menu="sudo netcfg-menu"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias pm-suspend="sudo pm-suspend"
alias pm-hibernate="sudo pm-hibernate"
alias umount="sudo umount"
alias tpfan-admin="sudo tpfan-admin"
alias khartoumtun="ssh -ND 52000 -v khartoum"
alias mount-work="encfs $_WORK_ENCFS_SOURCE $_WORK_ENCFS_DEST"
alias mount-dropbox="encfs $_DROPBOX_ENCFS_SOURCE $_DROPBOX_ENCFS_DEST"
alias set_battery_thresholds="sudo set_battery_thresholds"

# custom env vars
alias work="cd $WORK"
alias please="sudo"

function siq {
    # sets up virtualenv project path for work stuff directory. adds 
    # in a little reminder too.
    while [ ! -d "$_SIQ_PROJECT_HOME" ]; do
        mount-work
    done
    if [ "$_SIQ_ENV_ENABLED" -ne 1 ]; then
        function desiq {
            if [ -n "$VIRTUAL_ENV" ]; then
                deactivate
            fi
            if [ -n "$_PREV_PROJECT_HOME" ]; then
                export PROJECT_HOME=$_PREV_PROJECT_HOME
            fi
            if [ -n "$_PREV_PS1" ]; then
                export PS1=$_PREV_PS1
            fi
            export _SIQ_ENV_ENABLED=0
        }
        export _PREV_PROJECT_HOME=$PROJECT_HOME
        export PROJECT_HOME=$_SIQ_PROJECT_HOME
        export _PREV_PS1=$PS1
        export PS1="[siq]$PS1"
        export _SIQ_ENV_ENABLED=1
    fi
    if [ -n "$1" ]; then
        workon $1
    else 
        cd "$_SIQ_PROJECT_HOME"
    fi
}

fortune -e
