-- TODO: tab options and font size

vim.opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus"

vim.opt.guifont = "JetBrainsMono Nerd Font:h12"
vim.opt.termguicolors = true
vim.o.winborder = "rounded"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.textwidth = 80
-- Filetypes like markdown will re-add 't' through their ftplugin.
vim.opt.formatoptions:remove('t') -- not auto-wrap text (code)
vim.opt.formatoptions:append('a') -- watch for changes to re-format
vim.opt.formatoptions:append('w') -- paragraph must end with a non-white character

-- Tab size
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.number = true
vim.opt.cursorline = true

vim.opt.scrolloff = 4
vim.opt.wrap = false
vim.opt.signcolumn = "yes"

-- https://github.com/rmagatti/auto-session#%EF%B8%8F-configuration
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0
end
