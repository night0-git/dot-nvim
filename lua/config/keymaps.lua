local M = {}

local function map(mode, key, func, desc, extra_opts)
    local opts = vim.tbl_extend(
        "force",
        extra_opts or {},
        { desc = desc or "", }
    )

    vim.keymap.set(mode, key, func, opts)
end

-- Swap "L" for "J", "H" for "K".
map({"n", "v"}, "J", "L")
map({"n", "v"}, "L", "J")
map({"n", "v"}, "K", "H")
map({"n", "v"}, "H", "K")
-- Swap "p" for "P" to easily paste without overwriting register.
map({"x"}, "p", "P")
map({"x"}, "P", "p")

-- Keep selecting after indenting.
map("x", "<", "<gv")
map("x", ">", ">gv")

map("i", "<C-BS>", "<C-w>")

-- Navigate buffers.
-- map("n", "<C-[>", "<cmd>bnext<cr>")
-- map("n", "<C-]>", "<cmd>bprev<cr>")
map("n", "<leader><leader>", "<cmd>b#<cr>")

-- Easier pane navigation.
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows.
-- Helper to resize with awareness of pane position.
local function resize(dir, val)
    return function()
        local cur_winnr = vim.fn.winnr()
        local has_left  = vim.fn.winnr("h") ~= cur_winnr
        local has_right = vim.fn.winnr("l") ~= cur_winnr
        local has_up    = vim.fn.winnr("k") ~= cur_winnr
        local has_down  = vim.fn.winnr("j") ~= cur_winnr

        if dir == "up" then
            if has_up then vim.cmd("resize +" .. val)
            elseif has_down then vim.cmd("resize -" .. val) end
        elseif dir == "down" then
            if has_down then vim.cmd("resize +" .. val)
            elseif has_up then vim.cmd("resize -" .. val) end
        elseif dir == "left" then
            if has_left then vim.cmd("vertical resize +" .. val)
            elseif has_right then vim.cmd("vertical resize -" .. val) end
        elseif dir == "right" then
            if has_right then vim.cmd("vertical resize +" .. val)
            elseif has_left then vim.cmd("vertical resize -" .. val) end
        end
    end
end
map("n", "<C-Up>", resize("up", 2))
map("n", "<C-Down>", resize("down", 2))
map("n", "<C-Left>", resize("left", 2))
map("n", "<C-Right>", resize("right", 2))

-- Better terminal navigation.
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")
map("t", "<C-u>", "<C-\\><C-n>")

-- Shortcut for closing window, especially useful for fish's vi mode.
map({"n", "t"}, "<M-q>", function()
    local win = vim.api.nvim_get_current_win()

    pcall(vim.api.nvim_win_close, win, false)
end, "Close any window, including terminals")

local function feed_keys(key)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
end

-- Close floating window with Esc key. Any window can be assigned a tag 'float' 
-- to be closed by Esc.
vim.keymap.set("n", "<Esc>", function()
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)

    if vim.w[win].tag == "float" or config.relative ~= "" then
        pcall(vim.api.nvim_win_close, win, false)
    else
        feed_keys("<Esc>")
    end
end, { desc = "Close floating window" })

-- Decide between exitting fish's insert mode or nvim's terminal mode. This and 
-- the above keymap allow for presisng Esc multiple times to close a floating 
-- terminal in fish vi mode.
vim.keymap.set("t", "<Esc>", function()
    local buf = vim.api.nvim_get_current_buf()
    local shell_mode = vim.b[buf].shell_mode

    if shell_mode == "default" then
        feed_keys([[<C-\><C-n>]])
    else  -- either shell_mode is 'insert' or the shell is not fish
        feed_keys("<Esc>")
    end
end, { desc = "Exit terminal mode when fish shell is in normal mode" })

-- Clear copilot suggestions.
vim.keymap.set("i", "<Esc>", function()
    if not require("copilot-lsp.nes").clear() then
        feed_keys("<Esc>")
    end
end, { desc = "Clear copilot suggestion" })

M.map = map
return M
