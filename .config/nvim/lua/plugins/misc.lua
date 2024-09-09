return {
  { "mistweaverco/kulala.nvim", opts = {} },
  { "RRethy/nvim-align" },
  { "cbochs/grapple.nvim" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = true,
          debounce = 75,
        },
        filetypes = {
          ["*"] = true,
        },
      })
    end,
  },
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        render = "background",
        virtual_symbol = "■",
        enable_named_colors = false,
        enable_tailwind = false,
      })
    end,
  },
}
