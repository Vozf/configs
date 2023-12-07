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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/a_yaroshevich/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/a_yaroshevich/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/a_yaroshevich/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/a_yaroshevich/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
. /usr/share/undistract-me/long-running.bash
notify_when_long_running_commands_finish_install

defaultg=g1

#alias sshg='ssh ${defaultg}'
sshg() { ssh ${@:-$defaultg}; }
pf() { echo "-L localhost:$1:localhost:${2:-$1}"; }
sshpf() { ssh $(pf ${2:-$(tbport "$1")}) ${1:-$defaultg}; }

sshjn() { sshkilljn "$@"; ssh $(pf ${2:-$(jnport "$1")}) ${1:-$defaultg} "export PATH='/home/a_yaroshevich/anaconda3/bin:$PATH'; source activate rnd; jupyter notebook --port ${2:-$(jnport "$1")}"; }
sshkilljn() { ssh ${1:-$defaultg} "fuser -k ${2:-$(jnport "$1")}/tcp"; }
sshjnsettheme() { ssh ${1:-$defaultg} "export PATH="/home/a_yaroshevich/anaconda3/bin:$PATH";source activate ${2:-rnd}; pip install jupyterthemes; jt -t oceans16 -f roboto -cellw 95% -N -cursc x"; }
sshjnsetjn() { ssh ${1:-$defaultg} "export PATH="/home/a_yaroshevich/anaconda3/bin:$PATH";source activate ${2:-rnd}; conda install -y nb_conda; python -m ipykernel install --user --name ${2:-rnd}"; }
sshjnsetext() { ssh ${1:-$defaultg} "export PATH="/home/a_yaroshevich/anaconda3/bin:$PATH";source activate ${2:-rnd};  conda install -y -c conda-forge jupyter_contrib_nbextensions; jupyter nbextensions_configurator enable --user"; }
remotefs() { sshfs ${1:-$defaultg}:/${2:-/home} ${3:-~/remote}; }

jnport() {
	base_port=880;
	case $1 in
		"g1") base_port+=1 ;;
		"g2") base_port+=2 ;;
		"g3") base_port+=3 ;;
		"g4") base_port+=4 ;;
		"g5") base_port+=5 ;;
		*) return ;;
	esac 
	echo "$base_port"
}

tbport() {
	base_port=606;
	case $1 in
		"g1") base_port+=1 ;;
		"g2") base_port+=2 ;;
		"g3") base_port+=3 ;;
		"g4") base_port+=4 ;;
		"g5") base_port+=5 ;;
		*) return ;;
	esac 
	echo "$base_port"
}


alias sshkilltb='ssh  ${defaultg} "killall -r tensorboard"'

alias remount='sudo umount ~/remote -l; shoot sshfs; sshfsremote'
alias sshfsremote='sshfs -p 22 everest18:projects/ ~/remote'
alias remountmac='sudo umount ~/remotemac -l; shoot sshfs; sshfsremotemac'
alias sshfsremotemac='sshfs -p 22 mac:projects/pixomatic ~/remotemac'
alias copy='xclip -selection clipboard'
alias path='readlink -f'
alias sd='sudo shutdown -h now'
alias trackscroll='xinput set-prop $(xinput | grep M570 |  awk '\''{print substr($5,4,2)}'\'') "libinput Scroll Method Enabled" 0, 0, 1 && xinput set-prop $(xinput | grep M570 |  awk '\''{print substr($5,4,2)}'\'') "libinput Button Scrolling Button" 8'
alias jn='jupyter notebook'
alias copytogstorage='rsync -arz --info=progress2  ../../new_auto_masks.zip  -e "ssh -p 2200" gpu-storage@gpu-storage.indatalabs.com:~/storage/removebg/datasets/Bag_full_3'
alias close='killall -s INT -r '
alias shoot='killall -s KILL -r '
alias reconnectremote='shoot sshfs; unmount; sshfsremote'
alias vpn='echo -e "$(sudo cat ~/.cisco/pass.txt)\n$(ga okta)" | sudo openconnect --user=alexander.yaroshevic --passwd-on-stdin --authgroup okta-group --no-dtls --servercert pin-sha256:o+IlpWRoLj/Vp0kr/45dFVgpciVUrP/pu60yJHqgLNk -b asa.apalon.com'
alias copyga='bash -c "sleep 0.3 && ga okta | xclip -selection c"'
alias shutdown='shutdown -h now'
alias ga='ga-cmd'
alias sudo='sudo '
alias scp_local='scp -r -3'


export -f pf sshg sshpf sshjn sshkilljn remotefs sshjnsettheme sshjnsetjn sshjnsetext jnport tbport 

set -o vi
export PATH="/home/$USER/bin:$PATH"
export PATH="/home/$USER/.local/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if [ -f /etc/bash_completion ]; then
     . /etc/bash_completion 
fi

export GOOGLE_APPLICATION_CREDENTIALS=~/gcp_key.json

