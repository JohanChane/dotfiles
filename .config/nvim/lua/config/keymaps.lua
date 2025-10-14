-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "Y", '"+y', { noremap = true, silent = true })
if vim.g.neovide then
  vim.keymap.set("n", "<S-Insert>", '"+p', { noremap = true, silent = true })
  vim.keymap.set("v", "<S-Insert>", '"+p', { noremap = true, silent = true })
  vim.keymap.set("i", "<S-Insert>", "<C-r>+", { noremap = true, silent = true })
  vim.keymap.set("c", "<S-Insert>", "<C-r>+", { noremap = true, silent = false })

  vim.keymap.set("v", "<C-Insert>", '"+y', { noremap = true, silent = true })
end

vim.keymap.set("n", "<LocalLeader>tt", function()
  -- 获取当前文件所在目录
  local current_file = vim.fn.expand("%:p")
  local current_dir = current_file ~= "" and vim.fn.fnamemodify(current_file, ":h") or vim.fn.getcwd()

  -- 使用异步任务打开系统终端
  local terminal = vim.fn.getenv("TERMINAL")
  if not terminal or terminal == "" then
    terminal = "kitty" -- 默认终端
  end
  vim.fn.jobstart({ terminal, "--working-directory", current_dir }, {
    detach = true,
  })
end, { noremap = true, silent = true, desc = "Open system terminal in current directory" })
