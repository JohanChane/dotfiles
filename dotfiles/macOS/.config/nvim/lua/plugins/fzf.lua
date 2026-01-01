-- 让 FzfLua 也能像 fzf.vim 的 :BTags 那样“零 tags 文件”工作
return {
  "ibhagwan/fzf-lua", -- 插件声明
  dependencies = "junegunn/fzf",
  config = function()
    -- 临时生成当前文件 tags 并立即打开
    local function current_buf_tags()
      local tmp = vim.fn.tempname()
      vim.fn.system({
        "ctags",
        "-f",
        tmp,
        "--sort=yes",
        "--excmd=number",
        "--fields=nks",
        vim.api.nvim_buf_get_name(0), -- 当前 buffer 绝对路径
      })
      require("fzf-lua").btags({ ctags_file = tmp })
      vim.fn.delete(tmp)
    end
    -- 注册成用户命令，方便手动 :BTags
    vim.api.nvim_create_user_command("BTags", current_buf_tags, {})
  end,
  keys = {
    -- 默认 <leader>ct 触发
    { "<leader>ct", "<cmd>BTags<CR>", desc = "Ctags (current buffer)", mode = "n" },
  },
}
