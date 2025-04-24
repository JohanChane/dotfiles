return {
  {
    "JohanChane/fm.nvim",
    config = function()
      require("fm").setup({
        tools = {
          -- This configuration means: when pressing `o` in yazi, it will run the following command.
          -- The command is `yazi --chooser-file <choose_file> '<entry>'`
          -- `_choose_file` is internally used by fm.nvim (the name is fixed, not customizable)
          yazi = {
            create_win_cmd_format = "yazi --chooser-file %{_choose_file} '%{entry}'",
            suffix = "o",
          },
        },
      })

      local function get_path(modifier)
        local res = vim.fn.expand(modifier)
        if res == "" then
          res = vim.fn.getcwd()
        end
        return res
      end

      ---- ## Use `yazi` tool
      vim.keymap.set("n", "<M-d>", function()
        -- Final command: `yazi --chooser-file %{_choose_file} 'vim.fn.getcwd()'`
        require("fm").open_fm({ name = "yazi", cmd_params = { entry = vim.fn.getcwd() } })
      end, { noremap = true })

      vim.keymap.set("n", "<M-f>", function()
        -- Final command: `yazi --chooser-file %{_choose_file} 'get_path("%:p")'`
        require("fm").open_fm({ name = "yazi", cmd_params = { entry = get_path("%:p") } })
      end, { noremap = true })
    end,
  },
}
