return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
        java = false, -- don't check treesitter on java
      },
    })

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- import nvim-cmp plugin (completions plugin)
    local cmp = require("cmp")

    -- make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Add custom rules for Rust only
    local Rule = require("nvim-autopairs.rule")
    local cond = require("nvim-autopairs.conds")

    -- Add semicolon after a function call or method chain in Rust
    autopairs.add_rules({
      -- Add comma after closing parenthesis (e.g., function arguments) in Rust
      Rule("= ", ";", { "rust" }):with_pair(cond.not_inside_quote()):with_move(cond.none()), -- No move needed

      -- add comma after the fat arrow
      Rule("=>", ",", { "rust" }):with_pair(cond.not_inside_quote()):with_move(cond.none()), -- No move needed
    })
  end,
}
