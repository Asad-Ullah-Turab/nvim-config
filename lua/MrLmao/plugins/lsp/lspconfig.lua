return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opts = {} },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    require("mason").setup()
    require("mason-lspconfig").setup({
      automatic_enable = true, -- auto enable servers installed via mason
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Now use `vim.lsp.config()` to configure individual servers

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          completion = {
            callSnippet = "Replace",
          },
        },
      },
    })

    vim.lsp.config("graphql", {
      capabilities = capabilities,
      filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
    })

    vim.lsp.config("emmet_language_server", {
      capabilities = capabilities,
      filetypes = {
        "css",
        "eruby",
        "html",
        "javascript",
        "javascriptreact",
        "less",
        "sass",
        "scss",
        "pug",
        "typescriptreact",
      },
      init_options = {
        includeLanguages = {},
        excludeLanguages = {},
        extensionsPath = {},
        preferences = {},
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        showSuggestionsAsSnippets = false,
        syntaxProfiles = {},
        variables = {},
      },
    })
  end,
}

-- In the new version of mason-lspconfig this code is not needed anymore
--
--
-- -- import mason_lspconfig plugin
-- This require should now work as expected because mason-lspconfig.nvim is listed as a dependency.
-- local mason_lspconfig = require("mason-lspconfig")
--
--
-- mason_lspconfig.setup_handlers({
--   -- default handler for installed servers
--   function(server_name)
--     lspconfig[server_name].setup({
--       capabilities = capabilities,
--     })
--   end,
--   ["graphql"] = function()
--     -- configure graphql language server
--     lspconfig["graphql"].setup({
--       capabilities = capabilities,
--       filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
--     })
--   end,
--   ["emmet_ls"] = function()
--     -- configure emmet language server
--     -- Note: The actual server name for lspconfig is 'emmet_language_server'.
--     -- The key 'emmet_ls' here is what mason-lspconfig uses to identify the server from mason.
--     lspconfig["emmet_language_server"].setup({
--       capabilities = capabilities,
--       filetypes = {
--         "css",
--         "eruby",
--         "html",
--         "javascript",
--         "javascriptreact",
--         "less",
--         "sass",
--         "scss",
--         "pug",
--         "typescriptreact",
--         "vue", -- Added vue as it's a common use case for emmet
--       },
--       -- Read more about these options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
--       -- **Note:** only the options listed in the table are supported.
--       init_options = {
--         ---@type table<string, string>
--         includeLanguages = {}, -- Example: {javascript = "javascriptreact"}
--         --- @type string[]
--         excludeLanguages = {},
--         --- @type string[]
--         extensionsPath = {},
--         --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
--         preferences = {},
--         --- @type boolean Defaults to `true`
--         showAbbreviationSuggestions = true,
--         --- @type "always" | "never" Defaults to `"always"`
--         showExpandedAbbreviation = "always",
--         --- @type boolean Defaults to `false`
--         showSuggestionsAsSnippets = false,
--         --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
--         syntaxProfiles = {},
--         --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
--         variables = {},
--       },
--     })
--   end,
--   ["lua_ls"] = function()
--     -- configure lua server (with special settings for Neovim development)
--     lspconfig["lua_ls"].setup({
--       capabilities = capabilities,
--       settings = {
--         Lua = {
--           -- make the language server recognize "vim" global
--           diagnostics = {
--             globals = { "vim" },
--           },
--           completion = {
--             callSnippet = "Replace",
--           },
--           -- This helps lua_ls understand your Neovim runtime files for better diagnostics and completion.
--           workspace = {
--             library = vim.api.nvim_get_runtime_file("", true),
--             checkThirdParty = false, -- Avoids issues with third-party libraries if not managed by lua_ls
--           },
--           telemetry = {
--             enable = false, -- Disable telemetry
--           },
--         },
--       },
--     })
--   end,
-- })
