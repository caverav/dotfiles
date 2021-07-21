# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -lah'
    alias camilofvv='ssh camilofvv@camilo.fvv.cl'
    alias py='python3'
    alias speedtest='/home/camilo/C/ookla-speedtest-1.0.0-x86_64-linux/speedtest'
    alias android-studio='sh /home/camilo/androidstud/android-studio/bin/studio.sh'
    alias osu='wine /home/camilo/.wine/drive_c/users/camilo/Local\ Settings/Application\ Data/osu\!/osu\!.exe'
    alias edex='/home/camilo/Descargas/eDEX-UI-Linux-x86_64.AppImage --no-sandbox'
    alias cyberchef='firefox /home/camilo/Descargas/CyberChef/CyberChef_v9.27.6.html'
    alias apagao='sudo shutdown now'
    alias v='nvim'
    alias d='ranger'
    alias hola='bash .xinitrc & exit & xkill'
    alias push='xclip -sel clip /home/camilo/authgit && git push && echo 1 | xclip -sel clip'
    #alias alacritty='snap run alacritty'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/camilo/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/camilo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/camilo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/camilo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#export PATH="/home/camilo/.emacs.d/bin"
/home/camilo/.local/bin/fm6000 -c cyan -l 20 -dog -n -de dwm-camilo
export PATH="$HOME/.emacs.d/bin:$PATH"
. "$HOME/.cargo/env"
#export PATH="/snap/bin:$PATH"

source /home/camilo/.config/broot/launcher/bash/br
source ~/.local/share/icons-in-terminal/icons_bash.sh



function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

export PATH="/home/camilo/.local/bin:/home/camilo/.cargo/bin:/home/camilo/.emacs.d/bin:/home/camilo/miniconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/home/camilo/developer/flutter/bin:/snap/bin:/home/camilo/.dotnet/tools:/home/camilo/.fzf/bin"
source /home/camilo/alacritty/extra/completions/alacritty.bash
