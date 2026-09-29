return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        ---@module "fzf-lua"
        ---@type fzf-lua.Config|{}
        ---@diagnostic disable: missing-fields
        opts = {
            "telescope",
            winopts = {
                -- Because the picker window is a terminal, <C-j> and <C-k> need to
                -- be passed directly to fzf.
                on_create = function()
                    vim.keymap.set("t", "<C-j>", "<C-j>", { buffer = true, nowait = true })
                    vim.keymap.set("t", "<C-k>", "<C-k>", { buffer = true, nowait = true })
                end,
            },
            colorschemes = {
                actions = {
                    ["default"] = function(selected)
                        local scheme = selected[1]
                        vim.cmd("SetColorscheme " .. scheme)
                    end,
                },
            },
            actions = {
                files = {
                    ["ctrl-y"] = {
                        fn = function(selected)
                            vim.fn.setreg("+", selected[1])
                        end,
                        exec_silent = true,
                    },
                },
            },
        },
        ---@diagnostic enable: missing-fields

        keys = {
            -- { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
            -- { "<leader>fr", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
            { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find git files" },
            { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
            { "<leader>fc", "<cmd>FzfLua colorschemes<cr>", desc = "Find colorschemes" },
        },
    },

    {
        "dmtrKovalenko/fff",
        build = function()
            require("fff.download").download_or_build_binary()
        end,
        opts = {
            wrap_around = true,
            prompt = "> ",
            keymaps = {
                move_up = { "<Up>", "<C-k>" },
                move_down = { "<Down>", "<C-j>" },
            },
        },
        lazy = false,
        keys = {
            {
                "<leader>ff",
                function()
                    require("fff").find_files()
                end,
                desc = "FFFind files",
            },
            {
                "<leader>fr",
                function()
                    require("fff").live_grep()
                end,
                desc = "LiFFFe grep",
            },
        },
    },
}
