-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ";"
vim.opt.clipboard = ""

-- ========== 常用命令 ==========
-- 删除行尾空格命令
vim.api.nvim_create_user_command("StripRightSpace", function()
  vim.cmd("%s/\\s\\+$//e")
end, {})

vim.api.nvim_create_user_command("CdFileDir", function()
  local current_dir = vim.fn.expand("%:p:h")
  vim.cmd("cd " .. vim.fn.fnameescape(current_dir))
  vim.api.nvim_echo({ { current_dir } }, true, {})
end, {})
-- 切换文件换行符格式（DOS/UNIX）
vim.api.nvim_create_user_command("EidtWithDosFF", function()
  vim.cmd("e ++ff=dos")
end, {})
