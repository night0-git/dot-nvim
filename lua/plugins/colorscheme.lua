-- Manually pass variants for autocompletion because colorschemes are
-- lazy-loaded.
local function scheme_table(scheme, variants, main, opts)
    local tbl = {
        scheme,
        -- Active colorscheme will be loaded in init.lua.
        lazy = true,
        variants = variants or {},
        opts = opts or {},
    }
    if main then
        tbl.main = main
    end
    return tbl
end

return {
    scheme_table("oskarnurm/koda.nvim", {
        "koda",
        "koda-dark",
        "koda-light",
        "koda-moss",
        "koda-glade",
    }),
    scheme_table("folke/tokyonight.nvim", {
        "tokyonight",
        "tokyonight-night",
        "tokyonight-storm",
        "tokyonight-day",
        "tokyonight-moon",
    }),
    scheme_table("rebelot/kanagawa.nvim", {
        "kanagawa",
        "kanagawa-wave",
        "kanagawa-dragon",
        "kanagawa-lotus",
    }),
    scheme_table("olimorris/onedarkpro.nvim", {
        "onedark",
        "onelight",
        "onedark_vivid",
        "onedark_dark",
        "vaporwave",
    }),
    scheme_table("catppuccin/nvim", {
        "catppuccin",
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
    }, "catppuccin"),
    scheme_table("rose-pine/neovim", {
        "rose-pine",
        "rose-pine-main",
        "rose-pine-moon",
        "rose-pine-dawn",
    }, "rose-pine"),
    scheme_table("EdenEast/nightfox.nvim", {
        "nightfox",
        "dayfox",
        "dawnfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox",
    }),
    scheme_table("ellisonleao/gruvbox.nvim", {
        "gruvbox",
    }),
    scheme_table("sainnhe/gruvbox-material", {
        "gruvbox-material",
    }),
    scheme_table("neanias/everforest-nvim", {
        "everforest",
    }),
    scheme_table("AlexvZyl/nordic.nvim", {
        "nordic",
    }),
    scheme_table("shaunsingh/nord.nvim", {
        "nord",
    }),
    scheme_table("Mofiqul/dracula.nvim", {
        "dracula",
        "dracula-soft",
    }),
    scheme_table("scottmckendry/cyberdream.nvim", {
        "cyberdream",
    }),
    scheme_table("projekt0n/github-nvim-theme", {
        "github_dark",
        "github_dark_default",
        "github_dark_dimmed",
        "github_dark_high_contrast",
        "github_dark_colorblind",
        "github_dark_tritanopia",
        "github_light",
        "github_light_default",
        "github_light_high_contrast",
        "github_light_colorblind",
        "github_light_tritanopia",
    }, "github-theme"),
    scheme_table("loctvl842/monokai-pro.nvim", {
        "monokai-pro",
        "monokai-pro-spectrum",
        "monokai-pro-ristretto",
        "monokai-pro-machine",
        "monokai-pro-octagon",
        "monokai-pro-classic",
    }),
    scheme_table("ribru17/bamboo.nvim", {
        "bamboo",
        "bamboo-vulgaris",
        "bamboo-multiplex",
        "bamboo-light",
    }),
    scheme_table("sainnhe/sonokai", {
        "sonokai",
    }),
    scheme_table("sainnhe/edge", {
        "edge",
    }),
    scheme_table("bluz71/vim-nightfly-colors", {
        "nightfly",
    }),
    scheme_table("bluz71/vim-moonfly-colors", {
        "moonfly",
    }),
}
