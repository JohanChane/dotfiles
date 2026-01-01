return {
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        padding = false,
        sticky = true,
        mappings = {
          basic = true,
          extra = true,
        },
      })
    end,
  },
}
