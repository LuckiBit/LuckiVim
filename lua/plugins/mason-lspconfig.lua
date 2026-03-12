return {
    {
        "mason-org/mason-lspconfig.nvim",
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
            local project_dir = vim.fn.getcwd() -- Get the current project root directory
            local build_dir = project_dir .. "/build" -- Define the build directory
            local compile_commands_path = project_dir .. "/compile_commands.json" -- Path to compile_commands.json in the root

            -- Check if compile_commands.json exists in the project root directory
            local compile_commands_found = vim.fn.filereadable(compile_commands_path) == 1

            -- If not found in the root directory, check the build directory
            if not compile_commands_found then
                compile_commands_found = vim.fn.filereadable(build_dir .. "/compile_commands.json") == 1
            end

            -- If compile_commands.json is not found in both root and build directories, create a symlink
            if not compile_commands_found then
                vim.fn.system({
                    "ln",
                    "-s",
                    build_dir .. "/compile_commands.json",
                    project_dir .. "/compile_commands.json",
                })
            end

            vim.lsp.config("clangd", {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--compile-commands-dir=" .. (compile_commands_found and project_dir or build_dir),
                },
            })

            -- python
            -- markdown
        end,
    },
}
