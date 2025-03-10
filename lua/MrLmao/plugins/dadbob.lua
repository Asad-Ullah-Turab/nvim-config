return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_save_location = "~/database_ui_queries"
    vim.g.db_ui_use_nerd_fonts = 1

    -- custom keymaps
    vim.keymap.set("n", "<leader>db", ":DBUIToggle<CR>", { desc = "Toggle DBUI" })
  end,
}
