return {
  {
    "JohanChane/fm.nvim",
    --dir = '~/.config/nvim/lua/fm.nvim',
    config = function()
      require("fm").setup({
        ui = {
          default = "float",
          float = {
            border = "single", -- see ':h nvim_open_win'
            float_hl = "Normal", -- see ':h winhl'
            border_hl = "Normal",
            blend = 0, -- see ':h winblend'
            height = 0.9, -- Num from 0 - 1 for measurements
            width = 0.9,
            x = 0.5, -- X and Y Axis of Window
            y = 0.4,
          },
          split = {
            direction = "left", -- see `:h nvim_open_win()`
            width = 24,
            height = 16,
          },
        },
        tools = {
          ranger = {
            create_win_cmd_format = "ranger --choosefiles %{choose_file}",
            suffix = "l",
          },
          joshuto = {
            create_win_cmd_format = "joshuto --file-chooser --output-file %{choose_file}",
            suffix = "l",
          },
          yazi = {
            create_win_cmd_format = "yazi --chooser-file %{choose_file}",
            suffix = "o",
          },
          lazygit = {
            create_win_cmd_format = "lazygit",
            suffix = "e",
          },
        },
        debug = false,
      })

      local function get_path(modifier)
        return vim.fn.fnameescape(vim.fn.expand(modifier))
      end

      vim.keymap.set("n", "<M-d>", function()
        --require('fm').open_fm({ name = 'ranger', other_params = { '.' } })
        --require("fm").open_fm({ name = "joshuto", other_params = { "." } })
        require("fm").open_fm({ name = "yazi", other_params = { "." } })
      end, { noremap = true })
      vim.keymap.set("n", "<M-f>", function()
        -- final cmd: yazi --chooser-file %{choose_file} get_path('%:p')
        require("fm").open_fm({ name = "yazi", other_params = { get_path("%:p") } })
        --require("fm").open_fm({ name = "joshuto", other_params = { get_path("%:p:h") } })

        --[[
        local function open_ranger()
          local path = get_path('%:p')
          local other_params = {}
          if path == '' then
            other_params = {'.'}
          else
            other_params = { '--selectfile', path, '.' }
          end
          require('fm').open_fm({name = 'ranger', other_params = other_params})
        end
        open_ranger()
        --]]
      end, { noremap = true })

      -- If you want to create a command for `ranger`
      vim.api.nvim_create_user_command("Ranger", function(opts)
        require("fm").open_fm({ name = "ranger", other_params = { opts.args, "." } })
      end, { nargs = "?", complete = "dir", bang = true })
      vim.api.nvim_create_user_command("Lazygit", function(opt)
        require("fm").open_fm({ name = "lazygit", other_params = { "-w", get_path("%:p:h"), opt.args } })
      end, { nargs = "?", bang = true })
    end,
  },
}
