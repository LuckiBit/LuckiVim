return {
    {
        "hedyhli/outline.nvim",

        lazy = true,
        cmd = { "Outline", "OutlineOpen" },

        opts = {
            outline_window = {
                -- Where to open the split window: right/left
                position = "left",
            },
        },
        config = function(_, opts)
            require("outline").setup(opts)
        end,
    },
}
