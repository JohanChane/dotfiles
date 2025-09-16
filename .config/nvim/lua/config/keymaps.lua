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
