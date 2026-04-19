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
            -- =========================
            -- STM32 / ESP32 / Native C/C++
            -- =========================

            local function get_project_root()
                return vim.fs.root(0, {
                    ".git",
                    "compile_commands.json",
                    "CMakeLists.txt",
                    "idf.py",
                }) or vim.loop.cwd()
            end

            local function find_compile_commands_dir(root)
                local candidates = {
                    "build",
                    "build/Debug",
                    "build/Release",
                }

                for _, dir in ipairs(candidates) do
                    local path = root .. "/" .. dir .. "/compile_commands.json"
                    if vim.fn.filereadable(path) == 1 then
                        return root .. "/" .. dir
                    end
                end

                if vim.fn.filereadable(root .. "/compile_commands.json") == 1 then
                    return root
                end

                local found = vim.fs.find("compile_commands.json", {
                    path = root,
                    limit = 1,
                })

                if #found > 0 then
                    return vim.fn.fnamemodify(found[1], ":h")
                end

                return nil
            end

            -- =========================
            -- Mode selector
            -- =========================
            local MODE = "default" -- options: "default", "stm", "esp"

            -- =========================
            -- clangd binaries
            -- =========================
            local clangd_default = "clangd"

            local clangd_esp = "/Users/elegance/.espressif/tools/esp-clang/esp-20.1.1_20250829/esp-clang/bin/clangd"

            -- =========================
            -- project info
            -- =========================
            local root = get_project_root()
            local compile_dir = find_compile_commands_dir(root)

            -- =========================
            -- build cmd
            -- =========================
            local cmd = {}

            if MODE == "esp" then
                cmd = {
                    clangd_esp,
                    "--background-index",
                    "--clang-tidy",
                    "--query-driver=**xtensa-esp32-elf-gcc,**xtensa-esp32-elf-g++",
                }
            elseif MODE == "stm" then
                cmd = {
                    clangd_default,
                    "--background-index",
                    "--clang-tidy",
                    "--query-driver=**arm-none-eabi-gcc,**arm-none-eabi-g++",
                }
            else
                cmd = {
                    clangd_default,
                    "--background-index",
                    "--clang-tidy",
                }
            end

            -- =========================
            -- compile database (IMPORTANT)
            -- =========================
            if compile_dir then
                table.insert(cmd, "--compile-commands-dir=" .. compile_dir)
            end

            -- =========================
            -- better completion UX (optional but recommended)
            -- =========================
            table.insert(cmd, "--completion-style=detailed")
            table.insert(cmd, "--header-insertion=iwyu")

            -- =========================
            -- LSP setup
            -- =========================
            vim.lsp.config("clangd", {
                cmd = cmd,
                root_dir = root,
            })

            -- python
            -- markdown
        end,
    },
}
