# ## ls
export LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# ## grep
alias grep='grep --color=auto'

# ## Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export PATH="/root/pjnube:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"