return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true } },
      heading = {
        -- icons = { "󰼏 ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      },
      code = {
        language = false,
        left_pad = 1,
        right_pad = 1,
        width = "block",
        border = "thin",
      },
      html = {
        comment = {
          conceal = false,
        },
      },
      -- nvim's popup windows are markdown as well, and we don't want them to
      -- be affected.
      overrides = {
        buftype = { nofile = { enabled = false } },
      },
    },
  },

  {
    "sammaji/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    opts = {
      auto_close = false,
    },
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
    },
  },
}
