vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {
            default_file_explorer = true,
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
        dependencies = { "stevearc/oil.nvim" },
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
        dependencies = { "stevearc/oil.nvim" },
        opts = {},
    },

    {
        "https://github.com/nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = false,
        opts = {
            renderer = {
                group_empty = true,
                indent_markers = { enable = true },
            },
            update_focused_file = {
                -- Expand tree to reveal current file.
                enable = true,
            },
            view = {
                width = 25,
            },
            tab = {
                -- Keep tree consistent across tabs.
                sync = { open = true, close = true },
            },
            hijack_directories = {
                enable = false,
            },
            sync_root_with_cwd = true,
        },

        keys = {
            { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer (nvim-tree)" },
        },
    },
}
