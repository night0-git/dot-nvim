return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                globalstatus = true,
                component_separators = "",
                section_separators = "",
            },
            sections = {
                lualine_x = {},
                lualine_y = { "encoding", "fileformat", "filetype" },
            },
            extensions = { "nvim-tree", "lazy", "oil" },
        },
    },

    -- {
    --     "https://github.com/akinsho/bufferline.nvim",
    --     dependencies = "nvim-tree/nvim-web-devicons",
    --     lazy = false,
    --     opts = {
    --         options = {
    --             mode = "tabs",
    --             show_buffer_icons = false,
    --             show_buffer_close_icons = false,
    --             offsets = {
    --                 {
    --                     filetype = "NvimTree",
    --                     text = "File Explorer",
    --                     text_align = "center",
    --                     separator = true,
    --                 },
    --             },
    --         },
    --     },
    --     keys = {
    --         { "<C-n>", "<cmd>BufferLineCycleNext<cr>", desc = "Cycle to next buffer" },
    --         { "<C-p>", "<cmd>BufferLineCyclePrev<cr>", desc = "Cycle to previous buffer" },
    --     }
    -- },

    {
        "Bekaboo/dropbar.nvim",
        lazy = false,
        opts = function(_, opts)
            local default_enable = require("dropbar.configs").opts.bar.enable

            opts.bar = opts.bar or {}
            opts.bar.enable = function(buf, win, info)
                if vim.bo[buf].buftype == "terminal" or vim.fn.bufname(buf):match("^term://") then
                    return false
                end
                return default_enable(buf, win, info)
            end
        end,
        keys = {
            {
                "<leader>;",
                function()
                    require("dropbar.api").pick()
                end,
                desc = "Pick symbols in winbar",
            },
            {
                "[;",
                function()
                    require("dropbar.api").goto_context_start()
                end,
                desc = "Go to start of current context",
            },
            {
                "];",
                function()
                    require("dropbar.api").select_next_context()
                end,
                desc = "Select next context",
            },
        },
    },

    {
        "goolord/alpha-nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "rmagatti/auto-session",
        },
        lazy = true,
        config = function()
            local dashboard = require("alpha.themes.dashboard")
            local devicons = require("nvim-web-devicons")
            local WIDTH = 60

            local function truncate(str, max_len)
                return #str > max_len and ("…" .. str:sub(#str - max_len + 2)) or str
            end

            local function btn(key, label, cmd)
                -- Alpha uses "SPC" representation to map <leader>.
                local b = dashboard.button("SPC " .. key, label, cmd)
                b.opts.hl_shortcut = "Number"
                b.opts.width = WIDTH
                return b
            end

            local function get_mru_files(count)
                local items = {}
                for _, f in ipairs(vim.v.oldfiles or {}) do
                    if #items >= count then
                        break
                    end
                    if vim.fn.filereadable(f) == 1 then
                        local icon = devicons.get_icon(
                            vim.fn.fnamemodify(f, ":t"),
                            vim.fn.fnamemodify(f, ":e"),
                            { default = true }
                        ) or ""
                        local label = string.format("%s  %s", icon, truncate(vim.fn.fnamemodify(f, ":~:."), WIDTH - 10))
                        table.insert(
                            items,
                            btn(tostring(#items + 1), label, string.format("<cmd>edit %s<CR>", vim.fn.fnameescape(f)))
                        )
                    end
                end
                return items
            end

            local function get_recent_projects(count)
                local keys, items = { "a", "s", "d", "g", "h", "j", "k", "l" }, {}
                assert(count <= #keys, string.format("Project count (%d) exceeds available keys (%d)", count, #keys))

                local ok, auto_session = pcall(require, "auto-session")
                if not ok then
                    return {}
                end

                local root = auto_session.get_root_dir()
                local handle = vim.uv.fs_scandir(root)
                if not handle then
                    return {}
                end

                local files = {}
                while true do
                    local name, type = vim.uv.fs_scandir_next(handle)
                    if not name then
                        break
                    end
                    if type == "file" and name:match("%.vim$") then
                        local stat = vim.uv.fs_stat(root .. "/" .. name)
                        table.insert(files, { name = name, mtime = stat and stat.mtime and stat.mtime.sec or 0 })
                    end
                end
                table.sort(files, function(a, b)
                    return a.mtime > b.mtime
                end)

                for i = 1, math.min(#files, count) do
                    local path = files[i].name:gsub("%.vim$", ""):gsub("%%(%x%x)", function(h)
                        return string.char(tonumber(h, 16))
                    end)
                    local label = string.format("󰉋  %s", truncate(vim.fn.fnamemodify(path, ":~"), WIDTH - 10))
                    table.insert(
                        items,
                        btn(
                            keys[i],
                            label,
                            string.format("<cmd>lua require('auto-session').restore_session(%q)<cr>", path)
                        )
                    )
                end
                return items
            end

            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", "<cmd>enew | set buftype= buflisted<CR>"),
                dashboard.button("p", "  Recent projects", "<cmd>AutoSession search<CR>"),
                dashboard.button("f", "  Recent files", "<cmd>FzfLua oldfiles<CR>"),
                dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
            }

            dashboard.config.layout = {
                { type = "padding", val = 3 },
                dashboard.section.header,
                { type = "padding", val = 3 },
                dashboard.section.buttons,
                { type = "padding", val = 1 },
                { type = "text", val = "Recent Projects", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                {
                    type = "group",
                    val = function()
                        return get_recent_projects(5)
                    end,
                    opts = { spacing = 0 },
                },
                { type = "padding", val = 1 },
                { type = "text", val = "Recent Files", opts = { hl = "SpecialComment", position = "center" } },
                { type = "padding", val = 1 },
                {
                    type = "group",
                    val = function()
                        return get_mru_files(5)
                    end,
                    opts = { spacing = 0 },
                },
                { type = "padding", val = 1 },
                dashboard.section.footer,
            }

            -- Expose the config, and let auto-session spawn the dashboard.
            require("alpha").my_config = dashboard.config
            dashboard.config.opts.autostart = false

            require("alpha").setup(dashboard.config)
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            win = { border = "rounded" },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    {
        "kevinhwang91/nvim-hlslens",
        opts = {},
    },

    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            disabled_filetypes = {
                "help",
                "text",
                "markdown",
                "lazy",
                "mason",
                "alpha",
                "NvimTree",
                "lazy",
                "mason",
                "checkhealth",
                "lspinfo",
                "trouble",
                "qf",
            },
        },
    },
}
