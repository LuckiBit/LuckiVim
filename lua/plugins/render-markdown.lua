return {
    "MeanderingProgrammer/render-markdown.nvim",

    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

    opts = {
        -- Whether markdown should be rendered by default.
        enabled = true,
        completions = {
            -- Settings for blink.cmp completions source
            blink = { enabled = true },
            -- Settings for coq_nvim completions source
            coq = { enabled = false },
            -- Settings for in-process language server completions
            lsp = { enabled = false },
        },
    },

    config = function(_, opts)
        require("render-markdown").setup(opts)
    end,
}
