local map = vim.keymap.set

-- Paths
local root_path = vim.fn.getcwd() -- Current working directory
local cwd_path = vim.loop.cwd() -- Current working directory (libuv)
local home_path = vim.loop.os_homedir() -- User home directory

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

-- buffers
map("n", "<leader>bb", "<cmd>buffer #<cr>", { silent = true, desc = "Switch to Alternate Buffer" })
map("n", "<leader>bl", "<cmd>ls<cr>", { silent = true, desc = "List Buffers" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { silent = true, desc = "Delete Buffer" })
map("n", "<leader>bD", "<cmd>bdelete!<cr>", { silent = true, desc = "Force Delete Buffer" })
map("n", "<leader>bo", "<cmd>%bdelete|edit#|bdelete#<cr>", { silent = true, desc = "Delete Other Buffers" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { silent = true, desc = "Previous Buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { silent = true, desc = "Next Buffer" })

-- NvimTree
map("n", "<leader>e", function()
    require("nvim-tree.api").tree.open({ path = root_path })
end, { silent = true, desc = "NvimTree Root Dir" })

map("n", "<leader>E", function()
    require("nvim-tree.api").tree.open({ path = cwd_path })
end, { silent = true, desc = "NvimTree CWD" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { silent = true, desc = "New File" })

-- Telescope
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Find Buffers" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", { silent = true, desc = "Show Registers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { silent = true, desc = "Search in File" })

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear Search Highlight" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" })

-- Mason
map("n", "<leader>m", "<cmd>Mason<cr>", { silent = true, desc = "Mason" })

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

-- Quit all
map("n", "<leader>qq", "<cmd>qa<cr>", { silent = true, desc = "Quit All" })

-- Leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)", { silent = true, desc = "Leap Forward" })
map("n", "S", "<Plug>(leap-from-window)", { silent = true, desc = "Leap From Window" })
