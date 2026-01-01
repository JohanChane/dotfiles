-- ========== 基本设置 ==========
-- vim.opt.number = true                   -- 显示行号
vim.opt.cursorline = true -- 高亮当前行
vim.opt.syntax = "on" -- 语法高亮

-- ========== 文件类型检测和缩进 (修正语法) ==========
vim.cmd("filetype plugin on") -- 文件类型插件
vim.cmd("filetype indent on") -- 文件类型缩进

-- ========== 编码设置 (防止中文乱码) ==========
vim.opt.encoding = "utf-8" -- NeoVim 内部编码
vim.opt.fileencoding = "utf-8" -- 文件写入编码
vim.opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1" -- 自动检测编码顺序

-- ========== 缩进设置 (2个空格) ==========
vim.opt.tabstop = 2 -- Tab 显示宽度
vim.opt.shiftwidth = 2 -- 自动缩进宽度
vim.opt.expandtab = true -- Tab 转换为空格
vim.opt.softtabstop = 2 -- 退格键删除空格数
vim.opt.smartindent = true -- 智能缩进
vim.opt.autoindent = true -- 自动缩进

-- ========== 其他实用设置 ==========
vim.opt.ignorecase = true -- 搜索忽略大小写
vim.opt.smartcase = true -- 智能大小写匹配
vim.opt.incsearch = true -- 实时搜索高亮
vim.opt.hlsearch = true -- 搜索结果高亮
vim.opt.backup = false -- 不创建备份文件
vim.opt.swapfile = false -- 不创建交换文件
vim.opt.wrap = false -- 不自动换行
vim.opt.scrolloff = 5 -- 光标上下保留行数
vim.opt.sidescrolloff = 5 -- 光标左右保留列数

-- ========== 状态栏设置 ==========
vim.opt.laststatus = 2 -- 总是显示状态栏

-- 使用 Vimscript 配置 statusline
vim.cmd([[
  " 清空状态栏
  set statusline=

  " ========== 左侧内容 ==========
  set statusline+=%f                    " 文件名
  set statusline+=\ %m                  " 修改标志 [+]
  set statusline+=\ %r                  " 只读标志 [RO]

  " ========== 右对齐开始 ==========
  set statusline+=%=                    " 关键：从此处开始右对齐

  " ========== 右侧内容 ==========
  set statusline+=%y                    " 文件类型 (vim/python等)
  set statusline+=\                     " 空格分隔
  set statusline+=%{&ff}                " 文件格式 (unix/dos)
  set statusline+=\                     " 空格分隔
  set statusline+=%3p%%                 " 文件位置百分比
  set statusline+=\                     " 空格分隔
  set statusline+=%l                    " 当前行号
  set statusline+=,                     " 逗号分隔
  set statusline+=%c                    " 当前列号
]])

-- ========== 命令补全增强 ==========
vim.opt.wildmenu = true -- 启用命令行补全菜单
vim.opt.wildmode = "longest:full,full" -- 补全模式

-- ========== 颜色主题设置 ==========
vim.opt.termguicolors = true -- 启用真彩色支持
-- vim.cmd('colorscheme desert')           -- 设置颜色主题

-- ========== 补全菜单美化设置 ==========
vim.opt.pumblend = 10 -- 补全菜单透明度 (0-100)
vim.opt.pumheight = 10 -- 补全菜单最大高度
vim.opt.winblend = 10 -- 浮动窗口透明度

vim.cmd([[
  " 光标行高亮
  highlight CursorLine guibg=#2a2a2a

  " 设置 Visual 模式下的高亮颜色
  highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=#3a3a3a
  highlight VisualNOS cterm=NONE ctermbg=236 ctermfg=NONE guibg=#3a3a3a

  " 搜索高亮颜色
  highlight Search guibg=#555555 guifg=#ffffff
  highlight IncSearch guibg=#ff8800 guifg=#000000
]])

-- 设置补全菜单的高亮颜色
vim.cmd([[
  " 弹出菜单背景
  highlight Pmenu ctermbg=238 guibg=#444444
  " 选中项
  highlight PmenuSel cterm=bold ctermbg=24 ctermfg=255 gui=bold guibg=#005f87 guifg=#ffffff
  " 滚动条
  highlight PmenuSbar ctermbg=238 guibg=#444444
  " 滚动条滑块
  highlight PmenuThumb ctermbg=24 guibg=#005f87
]])

-- ========== 键盘映射 ==========
-- 设置 leader 键
vim.g.mapleader = ";"

-- ========== 文件类型特定设置 ==========
-- 创建自动命令组
local augroup = vim.api.nvim_create_augroup("MyAutoCmds", { clear = true })

-- Python 文件设置
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "python",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
	end,
})

-- Markdown 文件设置
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true -- 启用自动换行
		vim.opt_local.linebreak = true -- 在单词边界换行
	end,
})

-- ========== clipboard ==========
local function is_ssh()
  return vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
end

local function is_container()
  local cgroup = vim.fn.readfile('/proc/1/cgroup')
  for _, line in ipairs(cgroup) do
    if line:match('docker') or line:match('kubepods') or line:match('containerd') then
      return true
    end
  end
  return false
end

-- 只有远程或容器才启用 OSC 52
if is_ssh() or is_container() then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

vim.keymap.set({'n','v'}, 'Y', '"+y', { silent = true })

-- ========== 常用命令 ==========
-- 删除行尾空格命令
vim.api.nvim_create_user_command("StripRightSpace", function()
	vim.cmd("%s/\\s\\+$//e")
end, {})

-- 切换文件换行符格式（DOS/UNIX）
vim.api.nvim_create_user_command("EidtWithDosFF", function()
	vim.cmd("e ++ff=dos")
end, {})
