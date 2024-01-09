#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#alias ls='ls --color=auto'
alias ls='exa -gb'

alias lsd='exa -gb --icons'
alias ll='lsd -l'
alias la='lsd -laa'
alias lh='lsd -lh'
alias lah='lsd -lah'
alias grep='grep --color'
alias ip='ip -c=auto'
alias g="git-annex"
alias k="kde-open5"
alias x="xdg-open"

alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"

alias .="source"
alias cp="cp -i --reflink=auto --sparse=auto"
alias ssh="TERM=xterm-256color ssh"
alias bc="bc -lq"
alias numsum="tr '\n' '+' | sed 's/\+$/\n/' | bc"
alias pvb="pv -W -F'All:%b In:%t Cu:%r Av:%a %p'"
alias kwin-blur="xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0"
alias kwin-clear="xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -remove _KDE_NET_WM_BLUR_BEHIND_REGION"
alias gtar="tar -Ipigz czfv"
alias btar="tar -Ilbzip2 cjfv"
alias 7tar="7z a -mmt" 
alias xcp="rsync -aviHAXKhP --delete --exclude='*~' --exclude=__pycache__"
alias tmux="tmux -2"
alias :q="exit"
alias :w="sync"
alias :x="sync && exit"
alias :wq="sync && exit"
alias vim="nvim"

# pacman aliases and functions
function Syu(){
    sudo pacsync pacman -Sy && sudo pacman -Su $@  && sync -f /
    pacman -Qtdq | ifne sudo pacman -Rcs - && sync -f /
    sudo pacsync pacman -Fy && sync -f /
    pacdiff -o
}

alias Rcs="sudo pacman -Rcs"
alias Ss="pacman -Ss"
alias Si="pacman -Si"
alias Sl="pacman -Sl"
alias Sg="pacman -Sg"
alias Qs="pacman -Qs"
alias Qi="pacman -Qi"
alias Qo="pacman -Qo"
alias Ql="pacman -Ql"
alias Qlp="pacman -Qlp"
alias Qm="pacman -Qm"
alias Qn="pacman -Qn"
alias U="sudo pacman -U"
alias F="pacman -F"
alias Fo="pacman -F"
alias Fs="pacman -F"
alias Fx="pacman -Fx"
alias Fl="pacman -Fl"
alias Fy="sudo pacman -Fy"
alias Sy="sudo pacman -Sy"
alias Ssa="paru -Ssa"
alias Sas="paru -Ssa"
alias Sia="paru -Sia"
alias Sai="paru -Sia"

fs() {
  curl -s -F "c=@${1:--}" "https://fars.ee/?u=1" | tee /dev/tty | perl -p -e 'chomp if eof' | Ci
}

dsf(){
    # depends on diff-so-fancy
    git diff --color=always $@ | diff-so-fancy | less
}

aha-pipe() {
    $@ | ansi2html -m -t "$*" | sed '/.ansi2html-content {/a .ansi2html-content {font-family: monospace;}'
}

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;37m") \
		LESS_TERMCAP_md=$(printf "\e[1;37m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[0;36m") \
			man "$@"
}

ga-ncdu() {
    OUTPUT=$(ga-ncdu.pl ${1=.})
    echo -n $OUTPUT | ncdu -f-
}



# TMUX
if which tmux >/dev/null 2>&1; then
    # if no session is started, start a new session
    test -z ${TMUX} && tmux

    # when quitting tmux, try to attach
    while test -z ${TMUX}; do
        tmux attach || break
    done
fi

EDITOR="vim"
export EDITOR

#alias ls='ls --color=auto'
#alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
#then
#    exec fish
#fi

export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
