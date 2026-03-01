#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias la='ls -a'
alias ll='ls -la'

# prompt setting
PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\n\[\033[1;35m\]>\[\033[00m\] "

# completion setting (no distinction charactor size)
bind "set completion-ignore-case on"

# proxy setting
proxy_config_file=$HOME/.proxy
if [ -f "$proxy_config_file" ] && [ -s "$proxy_config_file" ]; then
	addr=$(head -n 1 $proxy_config_file)
	export http_proxy="http://$addr"
	export https_proxy="https://$addr"
fi
