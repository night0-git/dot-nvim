local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

vim.api.nvim_create_autocmd("VimResized", {
  desc = "Recalculate floating windows on resize",
  group = augroup,
  callback = function()
    -- Check if the current buffer is an Oil buffer.
    if vim.bo.filetype == "oil" then
      require("oil").close()
      require("oil").open_float()
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps",
  group = augroup,
  callback = function(event)
    local opts = {
      nowait = true,
      buffer = event.buf,
    }
    local map = require("config.keymaps").map
    local lsp = vim.lsp

    map("n", "K", function()
      lsp.buf.hover()
    end, "LSP hover documentation", opts)
    map("n", "gd", function()
      require("fzf-lua").lsp_definitions()
    end, "LSP definitions", opts)
    map("n", "gD", function()
      require("fzf-lua").lsp_declarations()
    end, "LSP declarations", opts)
    map("n", "ga", function()
      require("fzf-lua").lsp_code_actions({
        filter = function(action)
          return action.edit ~= nil or action.command ~= nil
        end,
        silent = true,
      })
    end, "LSP code actions", opts)
    map("n", "gr", function()
      require("fzf-lua").lsp_references()
    end, "LSP references", opts)
    map("n", "<leader>fd", function()
      require("fzf-lua").lsp_workspace_diagnostics()
    end, "LSP diagnostics", opts)
    map("n", "<leader>fD", function()
      require("fzf-lua").lsp_document_diagnostics()
    end, "LSP buffer diagnostics", opts)

    Snacks.toggle.inlay_hints():map("<leader>uh", opts)
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  desc = "Auto fold Obsidian's frontmatter",
  group = augroup,
  pattern = "*.md",
  callback = function(args)
    -- UFO loads asynchronously so we delay the execution.
    vim.defer_fn(function()
      if not vim.api.nvim_buf_is_valid(args.buf) then
        return
      end

      local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1]
      if first_line == "---" then
        pcall(vim.cmd, "1,1foldclose")
      end
    end, 100)
  end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
  desc = "Ensure floating window highlights are consistent across themes",
  group = augroup,
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    local border = vim.api.nvim_get_hl(0, { name = "FloatBorder" })

    -- Make floating windows have the same background as normal background.
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = normal.bg })
    -- Ensure consistency between border and background.
    vim.api.nvim_set_hl(0, "FloatBorder", {
      bg = normal.bg,
      fg = border.fg or normal.fg, -- preserve explicit foreground
    })

    -- NOTE: This part disables all background colors for all columns
    -- (number, signs...).
    local columns = {
      "SignColumn",
      "LineNr",
      "CursorLineNr",
      "GitSignsAdd",
      "GitSignsChange",
      "GitSignsDelete",
      "GitSignsTopdelete",
      "GitSignsChangedelete",
      "GitSignsUntracked",
      "DiagnosticSignError",
      "DiagnosticSignWarn",
      "DiagnosticSignInfo",
      "DiagnosticSignHint",
    }
    for _, col in ipairs(columns) do
      local hl = vim.api.nvim_get_hl(0, { name = col, link = false })
      if hl.bg then
        hl.bg = nil
        vim.api.nvim_set_hl(0, col, hl --[[@as vim.api.keyset.highlight]])
      end
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShell", {
  desc = "Suppress FileChangedShell warnings",
  group = augroup,
  callback = function()
    if vim.v.fcs_reason == "conflict" then
      -- If we have unsaved changes, suppress the prompt and keep our changes.
      vim.v.fcs_choice = ""
      vim.notify("File changed on disk. Use :e! to reload or :w to overwrite.", vim.log.levels.WARN)
    end
  end,
})
