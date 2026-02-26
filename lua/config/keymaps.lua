local map = vim.keymap.set
local root_path = vim.fn.getcwd()

-- Normal mode: open terminal
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Open Terminal (cwd)" })
map(
    "n",
    "<leader>tp",
    ":terminal cd " .. root_path .. " && pwsh<CR>",
    { silent = true, desc = "Open Terminal (Root Dir)" }
)

-- Split terminal
map(
    "n",
    "<leader>ts",
    ":belowright split | terminal<CR>",
    { silent = true, desc = "Terminal Horizontal Split (Below)" }
)
map("n", "<leader>tv", ":rightbelow vsplit | terminal<CR>", { silent = true, desc = "Terminal Vertical Split (Right)" })

-- Terminal mode mappings
map("t", "<C-n>", "<C-\\><C-n>", { silent = true, desc = "Exit Terminal Mode" })
map("t", "<C-q>", "<C-\\><C-n>:bd!<CR>", { silent = true, desc = "Close Terminal" })

-- <leader>om -> open :messages
map("n", "<leader>om", function()
    vim.cmd("new")
    vim.cmd("put =execute('messages')")
    vim.cmd("normal! gg")
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
end, { silent = true, desc = "Open messages output" })

-- <leader>oc -> capture any command output
map("n", "<leader>oc", function()
    vim.ui.input({ prompt = "Command: " }, function(cmd)
        if not cmd or cmd == "" then
            return
        end
        vim.cmd("new")
        vim.cmd("put =execute('" .. cmd .. "')")
        vim.cmd("normal! gg")
        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.bo.swapfile = false
    end)
end, { silent = true, desc = "Capture command output" })
