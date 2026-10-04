return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "ruff_format" },
            markdown = { "prettier" },
        },
        -- This will apply for conform.format(), and also format_on_save and
        -- format_after_save.
        default_format_opts = {
            lsp_format = "fallback",
            timeout_ms = 500,
        },
        format_on_save = function(bufnr)
            local ignore_filetypes = { "markdown" }

            if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
                return
            end

            return {}
        end,
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
