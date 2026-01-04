return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- Beautiful UI for variables/stack
      "nvim-neotest/nvim-nio", -- Required dependency for UI
      "williamboman/mason.nvim", -- To install debuggers
      "jay-babu/mason-nvim-dap.nvim", -- Bridges Mason with DAP
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup Mason-DAP Bridge
      require("mason-nvim-dap").setup({
        ensure_installed = { "cppdbg" },
        automatic_installation = true,
      })

      -- Setup the UI
      dapui.setup()

      -- Keybinds
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>bb", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>bu", dapui.toggle, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<leader>bc", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })

      -- Automatic UI opening/closing
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Set custom icons for breakpoints
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
    end,
  },
}
