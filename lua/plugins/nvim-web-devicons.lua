return {
    "nvim-tree/nvim-web-devicons",
    lazy = true,

    opts = {
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                cterm_color = "65",
                name = "Zsh",
            },
        },

        default = true, -- show default icon if no match
        color_icons = true, -- enable colored icons
        strict = true, -- strict filename/extension matching
        blend = 0, -- prevent width issues in popup menus

        override_by_filename = {
            [".gitignore"] = {
                icon = "",
                color = "#f1502f",
                name = "Gitignore",
            },
        },

        override_by_extension = {
            ["log"] = {
                icon = "",
                color = "#81e043",
                name = "Log",
            },
        },

        override_by_operating_system = {
            ["apple"] = {
                icon = "",
                color = "#A2AAAD",
                cterm_color = "248",
                name = "Apple",
            },
        },
    },
}
