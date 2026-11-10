local M = {}

function M.map(mode, key, func, desc, extra_opts)
  local opts = vim.tbl_extend("force", extra_opts or {}, { desc = desc or "" })

  vim.keymap.set(mode, key, func, opts)
end

-- Swap "p" for "P" to easily paste without overwriting register.
M.map({ "x" }, "p", "P")
M.map({ "x" }, "P", "p")

-- Keep selecting after indenting.
M.map("x", "<", "<gv")
M.map("x", ">", ">gv")

M.map("i", "<C-BS>", "<C-w>")

-- Navigate buffers.
-- M.map("n", "<C-[>", "<cmd>bnext<cr>")
-- M.map("n", "<C-]>", "<cmd>bprev<cr>")
M.map("n", "<leader><leader>", "<cmd>b#<cr>")

-- Resize with arrows.
-- Helper to resize with awareness of pane position.
local function resize(dir, val)
  return function()
    local cur_winnr = vim.fn.winnr()
    local has_left = vim.fn.winnr("h") ~= cur_winnr
    local has_right = vim.fn.winnr("l") ~= cur_winnr
    local has_up = vim.fn.winnr("k") ~= cur_winnr
    local has_down = vim.fn.winnr("j") ~= cur_winnr

    if dir == "up" then
      if has_up then
        vim.cmd("resize +" .. val)
      elseif has_down then
        vim.cmd("resize -" .. val)
      end
    elseif dir == "down" then
      if has_down then
        vim.cmd("resize +" .. val)
      elseif has_up then
        vim.cmd("resize -" .. val)
      end
    elseif dir == "left" then
      if has_left then
        vim.cmd("vertical resize +" .. val)
      elseif has_right then
        vim.cmd("vertical resize -" .. val)
      end
    elseif dir == "right" then
      if has_right then
        vim.cmd("vertical resize +" .. val)
      elseif has_left then
        vim.cmd("vertical resize -" .. val)
      end
    end
  end
end
M.map("n", "<C-Up>", resize("up", 2))
M.map("n", "<C-Down>", resize("down", 2))
M.map("n", "<C-Left>", resize("left", 2))
M.map("n", "<C-Right>", resize("right", 2))

-- Better terminal navigation.
M.map("t", "<C-h>", "<C-\\><C-n><C-w>h")
M.map("t", "<C-j>", "<C-\\><C-n><C-w>j")
M.map("t", "<C-k>", "<C-\\><C-n><C-w>k")
M.map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Shortcut for closing window, especially useful for fish's vi mode.
M.map({ "n", "t" }, "<M-q>", function()
  local win = vim.api.nvim_get_current_win()

  pcall(vim.api.nvim_win_close, win, false)
end, "Close any window, including terminals")

function M.feed_keys(key)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), "n", false)
end

-- Close floating window with Esc key. Any window can be assigned a tag 'float'
-- to be closed by Esc.
M.map("n", "<Esc>", function()
  local win = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win)

  if vim.w[win].tag == "float" or config.relative ~= "" then
    pcall(vim.api.nvim_win_close, win, false)
  else
    M.feed_keys("<Esc>")
  end
end, "Close floating window")

local function smart_copy(file_name_pattern)
  local mode = vim.api.nvim_get_mode().mode
  local file = vim.fn.expand(file_name_pattern)

  if mode == "n" then -- copy file name
    vim.fn.setreg("+", file)
  else -- copy file name with line numbers
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")

    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    local location = start_line == end_line and string.format("@%s:%d", file, start_line)
      or string.format("@%s:%d-%d", file, start_line, end_line)

    vim.fn.setreg("+", location)
    M.feed_keys("<Esc>")
  end
end

M.map({ "n", "v" }, "<leader>y", function()
  smart_copy("%:p:.")
end, "Smart copy (relative)")

M.map({ "n", "v" }, "<leader>Y", function()
  smart_copy("%:p")
end, "Smart copy (absolute)")

return M
