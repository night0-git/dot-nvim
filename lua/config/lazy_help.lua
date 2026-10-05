-- This module builds a symlinked help directory for all unloaded plugins, so that
-- their help files can always be accessed. This also helps auto-session
-- recreate any help buffer that would otherwise cause error if their plugin is
-- not eagerly loaded.

local root = vim.fn.stdpath("state") .. "/lazy-help"

-- Rebuild (symlink) all help files from all unloaded plugins into root.
local function rebuild()
    local ok, lazy = pcall(require, "lazy")
    if not ok then
        return
    end

    vim.fn.delete(root, "rf")
    local doc = root .. "/doc"
    vim.fn.mkdir(doc, "p")

    local seen = {}
    for _, plugin in ipairs(lazy.plugins()) do
        for _, file in ipairs(vim.fn.glob(plugin.dir .. "/doc/*", false, true)) do
            local name = vim.fn.fnamemodify(file, ":t")
            -- Help files are *.txt, or *.xxx for translations (e.g. foo.jax).
            if (name:match("%.txt$") or name:match("%.%a%ax$")) and not seen[name] then
                -- Note: if there is duplicate (rare) then the first one wins.
                seen[name] = true
                vim.uv.fs_symlink(file, doc .. "/" .. name)
            end
        end
    end
    vim.cmd("silent! helptags " .. vim.fn.fnameescape(doc))
end

-- Subsequent runs will only rebuild on Lazy events.
if not vim.uv.fs_stat(root .. "/doc/tags") then
    rebuild()
end
vim.opt.rtp:append(root) -- makes neovim recognize symlinked help files

vim.api.nvim_create_autocmd("User", {
    pattern = { "LazyInstall", "LazyUpdate", "LazySync", "LazyClean" },
    callback = rebuild,
})

vim.api.nvim_create_user_command("LazyHelpRebuild", rebuild, {})
