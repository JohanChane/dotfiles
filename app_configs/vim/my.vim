" ## vimplug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'lambdalisue/vim-suda'
"Plug 'ojroques/vim-oscyank', {'branch': 'main'}

call plug#end()

" ## vim-oscyank

" 判断是否为 SSH 会话
function! IsSSH()
  return $SSH_CLIENT !=# '' || $SSH_TTY !=# ''
endfunction

" 判断是否在容器里运行
function! IsContainer()
  " 读 /proc/1/cgroup，找不到文件就当不是容器
  if !filereadable('/proc/1/cgroup')
    return 0
  endif
  for line in readfile('/proc/1/cgroup')
    if line =~# 'docker\|kubepods\|containerd'
      return 1
    endif
  endfor
  return 0
endfunction

" 只有远程或容器才做后续 OSC 52 相关设置
if IsSSH() || IsContainer()
  vnoremap Y <Plug>OSCYankVisual
else
  if executable('wl-copy')
    vnoremap Y :w !wl-copy --trim-newline<CR><CR>
  elseif executable('xclip')
    vnoremap Y :w !xclip -sel clip<CR><CR>
  elseif executable('xsel')
    vnoremap Y :w !xsel -ib<CR><CR>
  endif
end

" ## ghostty
let &t_SI = "\e[6 q"   " 插入模式下竖线
let &t_EI = "\e[2 q"   " 普通模式下方块
let &t_SR = "\e[4 q"   " 替换模式下下划线

" ## 常用函数
" 删除行尾空格
command! StripRightSpace %s/\s\+$//e

" 以 DOS 换行符重新读入当前文件
command! EidtWithDosFF e ++ff=dos