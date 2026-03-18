-- Auto-update configuration: fix refresh issues when focus is lost or while typing
vim.api.nvim_create_autocmd(
    { "BufEnter", "CursorHold", "CursorHoldI", "FocusGained", "FocusLost", "TextChanged", "TextChangedI" },
    {
        pattern = { "*" },
        callback = function()
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
