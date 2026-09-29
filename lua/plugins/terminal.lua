local terms = {}
local persistent_id = 100 -- counts downward for persistent terminal's id
local active_targets = { "ALL" }

local function assign_persistent_id()
    persistent_id = persistent_id - 1
    return persistent_id + 1
end

local function get_session_name(cmd)
    local cwd = vim.fn.getcwd()
    local hash = vim.fn.sha256(cwd):sub(1, 8)
    local project_name = vim.fs.basename(cwd) or "root"
    project_name = project_name:gsub("[^%w_]", "_")
    return string.format("%s_%s_%s", project_name, cmd, hash)
end

local function tmux_has_session(session_name)
    local cmd = string.format("tmux has-session -t %s 2>/dev/null", vim.fn.shellescape(session_name))
    return os.execute(cmd) == 0
end

local function toggle_persistent_terminal(name, direction, cmd, extra_opts)
    local cwd = vim.fn.getcwd()
    local cache_key = cwd .. ":" .. name
    local session_name = get_session_name(name)
    local run_cmd = cmd or os.getenv("SHELL") or "bash"

    -- Track active persistent terminals' names for later deletion.
    if not vim.tbl_contains(active_targets, name) then
        table.insert(active_targets, name)
    end

    -- Check if a session has been deleted outside of neovim.
    if terms[cache_key] and not tmux_has_session(session_name) then
        terms[cache_key]:shutdown()
        terms[cache_key] = nil
    end

    if not terms[cache_key] then
        local Terminal = require("toggleterm.terminal").Terminal

        -- Wrap in persistent tmux session and disable status bar.
        local tmux_cmd = string.format(
            "tmux -f /dev/null new-session -A -s %s -c %s %s \\; set-option -t %s status off",
            vim.fn.shellescape(session_name),
            vim.fn.shellescape(cwd),
            vim.fn.shellescape(run_cmd),
            vim.fn.shellescape(session_name)
        )

        terms[cache_key] = Terminal:new(vim.tbl_deep_extend("force", {
            cmd = tmux_cmd,
            dir = cwd,
            count = assign_persistent_id(),
            direction = direction,
            hidden = true,
            close_on_exit = true,
        }, extra_opts or {}))
    end

    local term = terms[cache_key]

    if term:is_open() and term.direction ~= direction then
        term:close()
    end

    term:change_direction(direction)
    term:toggle()
end

-- Terminate tmux session and clean toggleterm instance.
local function reset_persistent_terminal(name, silent)
    local cwd = vim.fn.getcwd()
    local cache_key = cwd .. ":" .. name
    local session_name = get_session_name(name)
    if silent == nil then
        silent = false
    end

    vim.fn.system(string.format("tmux kill-session -t %s 2>/dev/null", vim.fn.shellescape(session_name)))

    if terms[cache_key] then
        terms[cache_key]:shutdown()
        terms[cache_key] = nil
    end

    if not silent then
        vim.notify("Reset " .. name .. " for: " .. vim.fs.basename(cwd), vim.log.levels.INFO)
    end
end

local function select_reset_session()
    vim.ui.select(active_targets, { prompt = "Reset session for current project:" }, function(choice)
        if not choice then
            return
        end
        if choice == "ALL" then
            for _, target in ipairs(active_targets) do
                if target ~= "ALL" then
                    reset_persistent_terminal(target, true)
                end
            end
            local cwd = vim.fn.getcwd()
            vim.notify("Reset all persistent terminals for: " .. vim.fs.basename(cwd), vim.log.levels.INFO)
        else
            reset_persistent_terminal(choice)
        end
    end)
end

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    opts = {
        persist_mode = false,
        float_opts = {
            border = "rounded",
        },
        size = function(term)
            if term.direction == "vertical" then
                return vim.o.columns * 0.5
            elseif term.direction == "horizontal" then
                return 20
            end
        end,
    },

    keys = {
        { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
        { "<leader>ts", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle terminal (horizontal)" },
        { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle terminal (vertical)" },

        { "<leader>t1", "<cmd>1ToggleTerm<cr>", desc = "Toggle terminal 1" },
        { "<leader>t2", "<cmd>2ToggleTerm<cr>", desc = "Toggle terminal 2" },
        { "<leader>t3", "<cmd>3ToggleTerm<cr>", desc = "Toggle terminal 3" },

        {
            "<leader>tf1",
            function()
                toggle_persistent_terminal("float_term_1", "float")
            end,
            desc = "Toggle persistent terminal 1",
        },
        {
            "<leader>tb1",
            function()
                toggle_persistent_terminal("float_term_1", "tab")
            end,
            desc = "Toggle persistent terminal 1",
        },
        {
            "<leader>tf2",
            function()
                toggle_persistent_terminal("float_term_2", "float")
            end,
            desc = "Toggle persistent terminal 2",
        },
        {
            "<leader>tb2",
            function()
                toggle_persistent_terminal("float_term_2", "tab")
            end,
            desc = "Toggle persistent terminal 2",
        },
        {
            "<leader>tf3",
            function()
                toggle_persistent_terminal("float_term_3", "float")
            end,
            desc = "Toggle persistent terminal 3",
        },
        {
            "<leader>tb3",
            function()
                toggle_persistent_terminal("float_term_3", "tab")
            end,
            desc = "Toggle persistent terminal 3",
        },

        {
            "<leader>tgf",
            function()
                toggle_persistent_terminal("lazygit", "float", "lazygit")
            end,
            desc = "Toggle LazyGit (float)",
        },
        {
            "<leader>tgb",
            function()
                toggle_persistent_terminal("lazygit", "tab", "lazygit")
            end,
            desc = "Toggle LazyGit (tab)",
        },

        {
            "<leader>tof",
            function()
                toggle_persistent_terminal("opencode", "float", "opencode")
            end,
            desc = "Toggle OpenCode (float)",
        },
        {
            "<leader>tob",
            function()
                toggle_persistent_terminal("opencode", "tab", "opencode")
            end,
            desc = "Toggle OpenCode (tab)",
        },

        {
            "<leader>tcf",
            function()
                toggle_persistent_terminal("codex", "float", "codex")
            end,
            desc = "Toggle Codex (float)",
        },
        {
            "<leader>tcb",
            function()
                toggle_persistent_terminal("codex", "tab", "codex")
            end,
            desc = "Toggle Codex (tab)",
        },

        { "<leader>tr", select_reset_session, desc = "Reset managed terminal session" },
    },
}
