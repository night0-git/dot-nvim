return {
    {
        "https://github.com/neovim/nvim-lspconfig",
        config = function()
            vim.diagnostic.config({
                virtual_text = true,
                float = {
                    source = true,
                    header = "",
                },
                severity_sort = true,
            })

            vim.lsp.config('basedpyright', {
                settings = {
                    basedpyright = {
                        analysis = {
                            inlayHints = {
                                variableTypes = true,
                                functionReturnTypes = true,
                            },
                        },
                    },
                },
            })
        end
    },

    {
        "mason-org/mason.nvim",
        opts = {
            ui = { border = "rounded" },
        }
    },

    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "clangd",
                "rust_analyzer",
                "basedpyright", "ruff",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
    }
}
