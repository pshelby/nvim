return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make", -- This is Optional, only if you want to use tiktoken_core to calculate tokens count
  opts = {
    provider = "claude",
    claude = {
      model = "claude-3-7-sonnet-20250219",
    },
  },
  dependencies = {
    "echasnovski/mini.icons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
}
