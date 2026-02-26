local opt = vim.opt

-- File handling
opt.autowrite = true -- Automatically save before running commands
opt.fileencodings = { "ucs-bom", "utf-8", "default", "latin1" } -- Encoding detection order when reading ("ucs-bom", "utf-8", "default", "latin1", "euc-cn", "cp936"; 8-bit must be last)
opt.fileformats = { "unix", "dos" } -- EOL detection order when reading (unix = \n, dos = \r\n, mac = \r)
opt.fileencoding = "utf-8" -- Encoding used when writing (utf-8 recommended)
opt.fileformat = "unix" -- EOL format when writing (unix recommended for cross-platform)

-- Indentation
opt.expandtab = true -- Convert tabs to spaces
opt.shiftwidth = 4 -- Spaces per indent
opt.tabstop = 4 -- Spaces a tab counts for
opt.autoindent = true -- Copy indentation from current line when starting a new line
opt.smartindent = false -- Automatically adjust indent based on C-like braces
opt.cindent = true -- Use C language indentation rules

-- Search
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Case-sensitive if uppercase used in search

-- UI
opt.number = true -- Show absolute line numbers
opt.relativenumber = true -- Show relative line numbers
opt.wrap = false -- Disable line wrapping
opt.winminwidth = 5 -- Minimum window width
opt.mouse = "a" -- Enable mouse in all modes

-- Spell checking
opt.spell = false -- Enable spell checking
opt.spelllang = { "en_us" } -- Spell language(s), e.g. "en_us", "en_gb"
