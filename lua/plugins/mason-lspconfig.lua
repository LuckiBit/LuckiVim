return {
    {
        "mason-org/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },

        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "pyright",
                "markdown_oxide",
            },
        },

        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            -- Lua
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            })

            -- clangd
            -- python
            -- markdown
        end,
    },
}
