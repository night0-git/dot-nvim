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
            -- nvim's popup windows are markdown as well, and we don't want them to
            -- be affected.
            overrides = {
                buftype = { nofile = { enabled = false } },
            },
        },
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
        keys = {
            { "<leader>mp", "<cmd>MarkdownPreview<cr>", desc = "Markdown Preview" },
        },
    },
}
