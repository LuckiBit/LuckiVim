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
map("n", "<leader>fa", function()
    require("telescope.builtin").find_files({
        find_command = {
            "rg",
            "--files",
            "--hidden",
            "--no-ignore",
            "--glob=!**/.git/*",
            "--glob=!**/node_modules/*",
            "--glob=!**/.cache/*",
        },
    })
end, { silent = true, desc = "Find All Files" })

map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { silent = true, desc = "Find Buffers" })
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { silent = true, desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { silent = true, desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { silent = true, desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope registers<cr>", { silent = true, desc = "Show Registers" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { silent = true, desc = "Search in File" })

-- LSP
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { silent = true, desc = "Goto Definitions" })
map("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>", { silent = true, desc = "Goto Type Definitions" })
-- map("n", "gr", "<cmd>Telescope lsp_references<cr>", { silent = true, desc = "Goto References" })
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { silent = true, desc = "Goto Implementations" })

map("n", "<leader>fi", "<cmd>Telescope lsp_incoming_calls<cr>", { silent = true, desc = "LSP Incoming Calls" })
map("n", "<leader>fo", "<cmd>Telescope lsp_outgoing_calls<cr>", { silent = true, desc = "LSP Outgoing Calls" })
map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", { silent = true, desc = "Document Symbols" })
map("n", "<leader>fS", "<cmd>Telescope lsp_workspace_symbols<cr>", { silent = true, desc = "Workspace Symbols" })
map("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { silent = true, desc = "Diagnostics" })

-- Clear search highlight
map("n", "<leader>h", "<cmd>nohlsearch<cr>", { silent = true, desc = "Clear Search Highlight" })

-- Lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { silent = true, desc = "Lazy" })

-- Mason
map("n", "<leader>mm", "<cmd>Mason<cr>", { silent = true, desc = "Mason" })

-- Markdown
map("n", "<leader>mt", "<cmd>RenderMarkdown toggle<cr>", { silent = true, desc = "Toggle RenderMarkdown" })

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

        local output = vim.fn.execute(cmd)

        vim.cmd("new")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))

        vim.bo.buftype = "nofile"
        vim.bo.bufhidden = "wipe"
        vim.bo.swapfile = false
    end)
end, { silent = true, desc = "Capture command output" })

-- <leader>od -> output diagnostics of current line
map("n", "<leader>od", function()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(0, { lnum = line })

    if #diags == 0 then
        print("No diagnostics on this line")
        return
    end

    local severity = {
        [vim.diagnostic.severity.ERROR] = "ERROR",
        [vim.diagnostic.severity.WARN] = "WARN",
        [vim.diagnostic.severity.INFO] = "INFO",
        [vim.diagnostic.severity.HINT] = "HINT",
    }

    local lines = {}
    for _, d in ipairs(diags) do
        table.insert(lines, severity[d.severity] .. ": " .. d.message)
    end

    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
end, { silent = true, desc = "Output diagnostics" })

-- <leader>oD -> output diagnostics of whole buffer
map("n", "<leader>oD", function()
    local diags = vim.diagnostic.get(0)

    if #diags == 0 then
        print("No diagnostics in this buffer")
        return
    end

    local severity = {
        [vim.diagnostic.severity.ERROR] = "ERROR",
        [vim.diagnostic.severity.WARN] = "WARN",
        [vim.diagnostic.severity.INFO] = "INFO",
        [vim.diagnostic.severity.HINT] = "HINT",
    }

    local lines = {}

    for _, d in ipairs(diags) do
        local line = d.lnum + 1
        local msg = string.format("%s:%d: %s", severity[d.severity], line, d.message)
        table.insert(lines, msg)
    end

    vim.cmd("new")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
end, { silent = true, desc = "Output buffer diagnostics" })

-- outline
map("n", "<leader>oo", "<cmd>Outline<CR>", { silent = true, desc = "Toggle Outline" })

-- Quit all
map("n", "<leader>qq", "<cmd>qa<cr>", { silent = true, desc = "Quit All" })

-- Leap
map({ "n", "x", "o" }, "s", "<Plug>(leap)", { silent = true, desc = "Leap Forward" })
map("n", "S", "<Plug>(leap-from-window)", { silent = true, desc = "Leap From Window" })

-- navigation
map("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end, { desc = "Next Diagnostic" })

map("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev Diagnostic" })

map("n", "]e", function()
    vim.diagnostic.jump({
        count = 1,
        severity = vim.diagnostic.severity.ERROR,
    })
end, { desc = "Next Error" })

map("n", "[e", function()
    vim.diagnostic.jump({
        count = -1,
        severity = vim.diagnostic.severity.ERROR,
    })
end, { desc = "Prev Error" })

map("n", "]w", function()
    vim.diagnostic.jump({
        count = 1,
        severity = vim.diagnostic.severity.WARN,
    })
end, { desc = "Next Warning" })

map("n", "[w", function()
    vim.diagnostic.jump({
        count = -1,
        severity = vim.diagnostic.severity.WARN,
    })
end, { desc = "Prev Warning" })

-- actions
map("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Line Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics Location List" })
map("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Diagnostics Quickfix List" })

map("n", "<leader>dt", function()
    vim.diagnostic.enable(true)
end, { desc = "Enable Diagnostics" })

map("n", "<leader>dT", function()
    vim.diagnostic.enable(false)
end, { desc = "Disable Diagnostics" })
