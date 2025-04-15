# # Basic Config
# ## Basic settings
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
export LESS='-i --incsearch -R'

# ### Color output in clonsole
alias ls='ls --color=auto'
alias ll='ls --color=auto -l'

alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias diff='diff --color=auto'

# ## Editor
# 为 sudo 保留 EDITOR 环境变量。`Defaults  env_keep += "EDITOR"`
export EDITOR='nvim'

# ## Terminal
export TERMINAL=ghostty
