return {
	{
		"JohanChane/wsnavigator.nvim",
		config = function()
			require("wsnavigator").setup({
				max_len_of_buffers = 7, -- Do not set this value above `20`, (recommended: `7`).
				cb_for_too_many_buffers = function() -- Callback function when buffer count exceeds `max_len_of_buffers`
					require("fzf-lua").buffers() -- Use `fzf-lua` for buffer switching when too many buffers are open. Please config your buffer switcher.
				end,
			})

			vim.keymap.set("n", "<LocalLeader>f", function()
				require("wsnavigator").open_wsn()
			end, { noremap = true })
		end,
	},
}
