return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff_format" },
      markdown = { "prettier" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      html = { "prettier" },
      c = { "clang-format" },
      cpp = { "clang-format" },
    },
    -- This will apply for conform.format(), and also format_on_save and
    -- format_after_save.
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 500,
    },
  },
  keys = {
    {
      "<leader>F",
      function()
        require("conform").format()
      end,
      desc = "Format buffer",
    },
  },
}
