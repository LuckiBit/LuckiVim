return {
  {
    "nvim-treesitter/nvim-treesitter",

    lazy = false,
    build = ":TSUpdate",

    config = function()
      -- basic setup
      require("nvim-treesitter").setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- install parsers
      require("nvim-treesitter").install({
      "bash",
      "c",
        "cpp",
      "html",
      "javascript",
        "lua",
        "markdown",
"python",
      })

      -- enable treesitter highlighting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "c", "cpp", "lua", "bash", "markdown", "python" },
        callback = function()
          vim.treesitter.start()
        end,
      })

    end,
  },
}