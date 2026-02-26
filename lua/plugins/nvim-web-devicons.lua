return {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
        default = true, -- show default icon if no match
        color_icons = true, -- enable colored icons
        strict = true, -- strict filename/extension matching
        blend = 0, -- prevent width issues in popup menus
    },
}
