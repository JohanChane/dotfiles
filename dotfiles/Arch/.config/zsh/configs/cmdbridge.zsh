# ## cmdbridge
# cmdbridge 补全
eval "$(_CMDBRIDGE_COMPLETE=zsh_source cmdbridge)"

# cmdbridge-edit 补全
eval "$(_CMDBRIDGE_EDIT_COMPLETE=zsh_source cmdbridge-edit)"

# 自定义补全函数
_cmdbridge_custom_complete() {
    local -a completions
    local -a completions_with_descriptions
    local -a response
    (( ! $+commands[cmdbridge] )) && return 1

    response=("${(@f)$(env COMP_WORDS="${words[*]}" COMP_CWORD=$((CURRENT-1)) _CMDBRIDGE_COMPLETE=zsh_complete cmdbridge)}")

    for type key descr in ${response}; do
        if [[ "$type" == "no_escape" ]]; then
            # 特殊处理：不使用转义
            completions+=("$key")
        elif [[ "$type" == "plain" ]]; then
            if [[ "$descr" == "_" ]]; then
                completions+=("$key")
            else
                completions_with_descriptions+=("$key":"$descr")
            fi
        fi
    done

    if [ -n "$completions_with_descriptions" ]; then
        _describe -V unsorted completions_with_descriptions -U
    fi

    if [ -n "$completions" ]; then
        # 关键：使用 -Q 选项避免转义
        compadd -Q -U -V unsorted -a completions
    fi
}

_cmdbridge_edit_custom_complete() {
    local -a completions
    local -a completions_with_descriptions
    local -a response
    (( ! $+commands[cmdbridge-edit] )) && return 1

    response=("${(@f)$(env COMP_WORDS="${words[*]}" COMP_CWORD=$((CURRENT-1)) _CMDBRIDGE_EDIT_COMPLETE=zsh_complete cmdbridge-edit)}")

    for type key descr in ${response}; do
        if [[ "$type" == "no_escape" ]]; then
            # 特殊处理：不使用转义
            completions+=("$key")
        elif [[ "$type" == "plain" ]]; then
            if [[ "$descr" == "_" ]]; then
                completions+=("$key")
            else
                completions_with_descriptions+=("$key":"$descr")
            fi
        fi
    done

    if [ -n "$completions_with_descriptions" ]; then
        _describe -V unsorted completions_with_descriptions -U
    fi

    if [ -n "$completions" ]; then
        # 关键：使用 -Q 选项避免转义
        compadd -Q -U -V unsorted -a completions
    fi
}

# 注册补全函数
compdef _cmdbridge_custom_complete cmdbridge
#compdef _cmdbridge_edit_custom_complete cmdbridge-edit

# bbe 包装函数 - cmdbridge-edit 的便捷别名
bbe() {
  local output
  output="$(command cmdbridge-edit "$@" 2>&1)"
  local ret=$?

  case $ret in
    113) print -z -- "$output" ;;  # 特殊退出码：将输出填充到命令行
    0)   echo "$output" ;;         # 正常退出：显示输出
    *)   echo "$output" >&2        # 错误退出：显示到标准错误
         return $ret ;;
  esac
}

# 为 bbe 也注册补全
compdef _cmdbridge_edit_custom_complete bbe
