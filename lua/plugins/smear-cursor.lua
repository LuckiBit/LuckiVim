return {
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",

        opts = {
            -- 🌈 Cursor color (pick one)

            cursor_color = "#39ff14",

            -- Alternative options (uncomment to use):
            -- cursor_color = "#00ffff", -- ⚡ Electric blue
            -- cursor_color = "#39ff14", -- 🟢 Neon green (fluorescent)
            -- cursor_color = "#ffff00", -- 💛 Neon yellow
            -- cursor_color = "#e0ffff", -- 🧊 Arctic ice (cold light cyan)
            -- cursor_color = "#ff4000", -- 🔥 Neon orange/red
            -- cursor_color = "#bb9af7", -- 🌌 Tokyonight purple (subtle)
            -- cursor_color = "#7dcfff", -- 🌊 Tokyonight cyan (clean)
            -- cursor_color = "#ffffff", -- ⚪ Pure white
            -- cursor_color = "#000000", -- ⚫ Pure black (only works well on light backgrounds)
        },

        config = function(_, opts)
            require("smear_cursor").setup(opts)
        end,
    },
}
