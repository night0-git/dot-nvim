return {
  {
    "https://github.com/neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        float = {
          source = true,
          header = "",
        },
        severity_sort = true,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- This is disabled by default on Linux.
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
      -- Apply to ALL LSP servers.
      vim.lsp.config("*", {
        capabilities = capabilities,
      })
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },

  { -- Maps and auto enables any Mason-installed LSP server.
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  { -- Auto installs LSP servers, linters, and formatters.
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason-org/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "luacheck",
        "clangd",
        "clang-format",
        "rust-analyzer",
        "basedpyright",
        "ruff",
        "prettier",
        "mmdc",
        "vtsls",
        "html-lsp",
        "css-lsp",
      },
    },
  },
}
