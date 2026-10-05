vim.opt_local.conceallevel = 2

-- Enable soft wrapping.
vim.opt_local.wrap = true
vim.opt_local.linebreak = true

-- Disable hard auto-wrapping.
vim.opt_local.textwidth = 0
vim.opt_local.formatoptions:remove("t")
vim.opt_local.formatoptions:remove("a")
