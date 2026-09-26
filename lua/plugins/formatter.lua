return {
    "stevearc/conform.nvim",
    opts = {
        -- Set and enable formatter here.
        -- formatters_by_ft = {
        --     lua = { "stylua" },
        --     go = { "goimports", "gofmt" },
        --     rust = { "rustfmt", lsp_format = "fallback" },
        --     python = function(bufnr)
        --       if require("conform").get_formatter_info("ruff_format", bufnr).available then
        --         return { "ruff_format" }
        --       else
        --         return { "isort", "black" }
        --       end
        --     end,
        -- },
        format_on_save = {
            timeout_ms = 500,
        },
    },
}
