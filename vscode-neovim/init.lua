-- Separate config file for the vscode-neovim extension.

vim.opt.clipboard = "unnamedplus"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.textwidth = 80
-- Filetypes like markdown will re-add 't' through their ftplugin.
vim.opt.formatoptions:remove("t") -- not auto-wrap text (code)
vim.opt.formatoptions:append("a") -- watch for changes to re-format
vim.opt.formatoptions:append("w") -- paragraph must end with a non-white character

-- Tab size
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

vim.opt.scrolloff = 4
vim.opt.wrap = false

local function map(mode, key, func, desc, extra_opts)
  local opts = vim.tbl_extend("force", extra_opts or {}, { desc = desc or "" })

  vim.keymap.set(mode, key, func, opts)
end

-- Swap "L" for "J", "H" for "K".
map({ "n", "v" }, "J", "L")
map({ "n", "v" }, "L", "J")
map({ "n", "v" }, "K", "H")
map({ "n", "v" }, "H", "K")
-- Swap "p" for "P" to easily paste without overwriting register.
map({ "x" }, "p", "P")
map({ "x" }, "P", "p")
-- Keep selecting after indenting.
map("x", "<", "<gv")
map("x", ">", ">gv")
