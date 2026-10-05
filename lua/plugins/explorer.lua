vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    {
        "night0-git/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            -- Prevent oil from hijacking restored session.
            default_file_explorer = false,
            watch_for_changes = true,
            win_options = {
                signcolumn = "yes:2",
            },
            view_options = {
                show_hidden = true,
            },
            float = {
                border = "rounded",

                max_width = 0.8,
                max_height = 0.8,
            },
        },

        keys = {
            {
                "<leader>o",
                function()
                    require("oil").toggle_float()
                end,
                desc = "Open file explorer (Oil)",
            },
        },
    },

    {
        "malewicz1337/oil-git.nvim",
        dependencies = { "night0-git/oil.nvim" },
        opts = {
            symbol_position = "signcolumn",
            symbols = {
                file = {
                    added = "A",
                    modified = "M",
                    renamed = "R",
                    deleted = "D",
                    copied = "C",
                    conflict = "!",
                    untracked = "?",
                    ignored = "·",
                },
                directory = {
                    added = "A",
                    modified = "M",
                    renamed = "R",
                    deleted = "D",
                    copied = "C",
                    conflict = "!",
                    untracked = "?",
                    ignored = "·",
                },
            },
        },
    },

    {
        "JezerM/oil-lsp-diagnostics.nvim",
        dependencies = { "night0-git/oil.nvim" },
        opts = {},
    },
}
