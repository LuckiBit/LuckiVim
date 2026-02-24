-- Load core configuration modules in the correct order

-- 1. Global variables (must be loaded first)
require("config.globals")

-- 2. Neovim options
require("config.options")

-- 3. Key mappings
require("config.keymaps")

-- 4. Autocommands
require("config.autocmds")

-- 5. Plugin manager (must be loaded last)
require("config.lazy")
