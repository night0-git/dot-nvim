M = {}

local state_path = vim.fn.stdpath("data") .. "/current_colorscheme.txt"

local function trimmed(str)
    return str:gsub("^%s*(.-)%s*$", "%1")
end

local set_scheme = vim.cmd.colorscheme

function M.load_colorscheme()
    local state_file = io.open(state_path, "r")
    if not state_file then
        return false, "colorscheme file not found"
    end

    local scheme = trimmed(state_file:read("*l") or "")
    state_file:close()

    local success, msg = pcall(set_scheme, scheme)
    if not success then
        return false, msg
    end
    return true
end

function M.set_and_save_colorscheme(scheme)
    local success, msg = pcall(set_scheme, scheme)
    if not success then
        return false, msg
    end


    local state_file = io.open(state_path, "w")
    if not state_file then
        return false, "failed to write colorscheme file"
    end
    state_file:write(scheme)
    state_file:close()
    return true
end

return M

