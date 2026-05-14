local M = {}

-- Check if xxd is available in the system
local has_xxd = vim.fn.executable("xxd") == 1

function M.is_hex()
    return vim.b.hex_mode == true
end

function M.hex_on()
    if not has_xxd then
        vim.notify("xxd not found in PATH", vim.log.levels.ERROR)
        return
    end
    if M.is_hex() then return end

    -- Disable undo recording during conversion to prevent corruption
    local old_undolevels = vim.opt.undolevels:get()
    vim.opt.undolevels = -1

    -- Set buffer options for binary editing
    vim.opt_local.binary = true
    vim.opt_local.wrap = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    
    -- Convert binary to hex via xxd (silent to avoid prompt)
    vim.cmd("silent %!xxd")
    
    -- Set filetype and internal flag
    vim.bo.filetype = "xxd"
    vim.b.hex_mode = true
    
    -- Restore undo levels
    vim.opt.undolevels = old_undolevels
end

function M.hex_off()
    if not M.is_hex() then return end

    -- Disable undo recording during conversion
    vim.opt.undolevels = -1
    
    -- Convert hex back to binary (silent to avoid prompt)
    vim.cmd("silent %!xxd -r")
    
    -- Restore standard buffer options
    vim.opt_local.binary = false
    vim.opt_local.wrap = true
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
    
    -- Clear hex flag and detect filetype automatically
    vim.b.hex_mode = false
    vim.cmd("filetype detect")
    
    -- Restore undo levels
    vim.opt.undolevels = 1000
end

function M.toggle()
    if M.is_hex() then M.hex_off() else M.hex_on() end
end

return M
