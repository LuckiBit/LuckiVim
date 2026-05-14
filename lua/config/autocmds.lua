local hex = require("config.hex")

-- Auto-update configuration: fix refresh issues when focus is lost or while typing
vim.api.nvim_create_autocmd(
    { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "FocusLost", "TextChanged", "TextChangedI" },
    {
        pattern = { "*" },
        callback = function()
            -- Skip if in hex mode or currently performing hex conversion to avoid corruption
            if vim.b.hex_mode or vim.b.saving_hex then
                return
            end

            -- 1. Sync changes from external sources
            if vim.api.nvim_get_mode().mode ~= "c" then
                vim.cmd("checktime")
            end
            -- 2. Trigger preview sync by saving when file is modified and not read-only
            if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" then
                vim.cmd("silent! update")
            end
        end,
    }
)

-- Hex editing automation
local hex_group = vim.api.nvim_create_augroup("HexEditing", { clear = true })

-- Enable hex mode automatically for binary files
vim.api.nvim_create_autocmd("BufReadPost", {
    group = hex_group,
    pattern = { "*.bin", "*.elf", "*.o", "*.a", "*.out" },
    callback = function()
        hex.hex_on()
    end,
})

-- Convert hex back to binary before saving
vim.api.nvim_create_autocmd("BufWritePre", {
    group = hex_group,
    pattern = "*",
    callback = function()
        if hex.is_hex() then
            vim.b.saving_hex = true
            vim.cmd("%!xxd -r")
        end
    end,
})

-- Restore hex view after saving
vim.api.nvim_create_autocmd("BufWritePost", {
    group = hex_group,
    pattern = "*",
    callback = function()
        if hex.is_hex() then
            vim.cmd("%!xxd")
            vim.bo.filetype = "xxd"
            vim.b.saving_hex = false
            -- Reset modified flag as the conversion marks the buffer as dirty
            vim.bo.modified = false
        end
    end,
})

-- Real-time refresh timer: sync changes from external sources every 100ms
-- This ensures files are updated even when in Terminal mode or other modes where CursorHold doesn't trigger.
local timer = vim.loop.new_timer()
if timer then
    timer:start(
        100,
        100,
        vim.schedule_wrap(function()
            -- Only checktime if not in command-line mode to avoid interrupting typing
            if vim.api.nvim_get_mode().mode ~= "c" then
                vim.cmd("checktime")
            end
        end)
    )
end
