return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim", -- Required UI library
      "rcarriga/nvim-notify", -- Optional but recommended for notifications
    },
    config = function()
      -- Set up nvim-notify
      require("notify").setup({
        -- You can customize options for nvim-notify here
        background_colour = "#000000",
        stages = "fade_in_slide_out", -- Fade in with slide-out animation
        timeout = 3000,
        render = "simple",
        max_width = 80, -- Adjust this value to control line wrapping
        fps = 60, -- A
      })

      -- Set up noice.nvim
      require("noice").setup({
        cmdline = {
          enabled = true,
          view = "cmdline_popup", -- or "cmdline", "cmdline_popup"
        },
        messages = {
          enabled = true, -- prettifies messages
        },
        popupmenu = {
          enabled = false, -- nice popup menu
        },
        routes = {
          {
            filter = { event = "msg_show" },
            opts = { skip = true }, -- Skip regular messages if you want to use notifications instead
          },
        },
        notify = {
          enabled = true, -- Enable notifications through noice
        },
      })
    end,
  },
}
