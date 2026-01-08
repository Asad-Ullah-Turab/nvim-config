return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- 1. Setup Mason-DAP Bridge
      require("mason-nvim-dap").setup({
        -- Changed to codelldb for better reliability on Arch
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })

      -- 2. Setup the UI
      dapui.setup()

      -- 3. Define the Adapter (Manual path to ensure it finds Mason's binary)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }

      -- 4. Configurations
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb", -- Matches the adapter name above
          request = "launch",
          program = function()
            local file = vim.fn.expand("%")
            local output = vim.fn.expand("%:p:h") .. "/debug_out"

            -- Compiling with -g for debug symbols
            print("Compiling " .. file .. "...")
            local result = os.execute(string.format("g++ -g -std=c++17 '%s' -o '%s'", file, output))

            if result == 0 then
              return output
            else
              print("Compilation failed!")
              return dap.ABORT
            end
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Link C to use same config as CPP
      dap.configurations.c = dap.configurations.cpp

      -- Keybinds (Using your leader prefixes)
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

      vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>bu", dapui.toggle, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<leader>bc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })

      -- 6. Automatic UI opening/closing
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- 7. Signs
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
  },
}
