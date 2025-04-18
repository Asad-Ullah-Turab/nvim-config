return {
  "AlphaTechnolog/pywal.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("pywal").setup()
    -- Then set the colorscheme
    vim.cmd("colorscheme pywal")
  end,
}
