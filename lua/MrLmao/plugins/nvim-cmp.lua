return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "hrsh7th/cmp-cmdline", -- source for command-line completion
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- follow latest release
      build = "make install_jsregexp", -- install jsregexp (optional)
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["˚"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["∆"] = cmp.mapping.select_next_item(), -- next suggestion
        ["∫"] = cmp.mapping.scroll_docs(-4), -- scroll docs up
        ["ƒ"] = cmp.mapping.scroll_docs(4), -- scroll docs down
        [" "] = cmp.mapping.complete(), -- show completion suggestions
        ["´"] = cmp.mapping.abort(), -- close completion window
        ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- confirm selection
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
        { name = "vim-dadbod-completion" }, -- dadbod database
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
        }),
      },
    })

    -- Command-line completion setup
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" }, -- file system paths
        { name = "cmdline", option = { igonre_cmds = { "Man", "!" } } }, -- command-line completions
      }),
    })
  end,
}
