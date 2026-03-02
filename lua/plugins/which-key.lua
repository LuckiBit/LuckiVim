return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps",
        },
    },
    config = function(_, opts)
        local wk = require("which-key")
        wk.setup(opts)

        wk.add({
            { "<leader>b", group = "+buffers", icon = { icon = "", color = "cyan" } },
            { "<leader>bb", desc = "Switch to Alternate Buffer", icon = { icon = "󰕌", color = "green" } },
            { "<leader>bl", desc = "List Buffers", icon = { icon = "󰈔", color = "blue" } },
            { "<leader>bd", desc = "Delete Buffer", icon = { icon = "󰅖", color = "red" } },
            { "<leader>bD", desc = "Force Delete Buffer", icon = { icon = "󰅙", color = "red" } },
            { "<leader>bo", desc = "Delete Other Buffers", icon = { icon = "󰶐", color = "orange" } },
            { "<leader>bp", desc = "Previous Buffer", icon = { icon = "󰒮", color = "cyan" } },
            { "<leader>bn", desc = "Next Buffer", icon = { icon = "󰒭", color = "cyan" } },
            {
                "<leader>e",
                group = "NvimTree Root Dir",
                icon = { icon = "󰙅", color = "green" },
            },
            {
                "<leader>E",
                group = "NvimTree CWD",
                icon = { icon = "󰙅", color = "yellow" },
            },
            { "<leader>f", group = "+file/find" },
            { "<leader>t", group = "+terminal" },
            { "<leader>tt", desc = "Open Terminal (cwd)", icon = { icon = "󰆍", color = "green" } },
            { "<leader>tp", desc = "Open PowerShell in Root Dir", icon = { icon = "󰨊", color = "azure" } },
            { "<leader>ts", desc = "Terminal Horizontal Split (Below)", icon = { icon = "󰤻", color = "cyan" } },
            { "<leader>tv", desc = "Terminal Vertical Split (Right)", icon = { icon = "󰤼", color = "cyan" } },
            { "<leader>o", group = "+output", icon = { icon = "󰈙", color = "purple" } },
            { "<leader>l", group = "Lazy", icon = { icon = "󰒲", color = "blue" } },
            { "<leader>q", group = "+quit/session" },
            { "<leader>w", proxy = "<c-w>", group = "+windows" },
        })
    end,
}
