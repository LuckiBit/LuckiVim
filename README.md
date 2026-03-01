# LuckiVim

[LuckiVim](https://github.com/LuckiBit/LuckiVim) is a clean and modular Neovim configuration powered by lazy.nvim. It provides a fast, lightweight, and easy-to-extend setup.

## ✨ Features

- Clean and organized Lua structure  
- Fast and minimal  
- Modular configuration  
- Powered by lazy.nvim  
- Modern UI and plugin integration  

## ⚡ Requirements

- Neovim 0.11.6 or later
- Git
- Nerd Font (optional but recommended)
- fd (used by Telescope)
- ripgrep (used by Telescope)
- stylua (for Lua formatting)
- cmake (required for building telescope-fzf-native.nvim and other native extensions)
- tree-sitter-cli (for nvim-treesitter)
- A C compiler (required for nvim-treesitter)

## 🚀 Getting Started

> [!NOTE]
> Back up your existing Neovim configuration before installing LuckiVim.

Neovim configuration paths:

| OS | PATH |
| :- | :--- |
| Linux, macOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd) | `%localappdata%\nvim\` |
| Windows (PowerShell) | `$env:LOCALAPPDATA\nvim\` |

### Install LuckiVim

<details><summary> Linux and macOS </summary>

```sh
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Clone LuckiVim
git clone https://github.com/LuckiBit/LuckiVim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# Optional: remove git history if you want to use your own repo
rm -rf ~/.config/nvim/.git
````

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```bat
ren %localappdata%\nvim nvim.bak
git clone https://github.com/LuckiBit/LuckiVim.git "%localappdata%\nvim"
```

If you're using `PowerShell`:

```powershell
Rename-Item $env:LOCALAPPDATA\nvim nvim.bak
git clone https://github.com/LuckiBit/LuckiVim.git "$env:LOCALAPPDATA\nvim"
```

</details>

### Post Installation

Start Neovim:

```sh
nvim
```

On first launch, lazy.nvim will automatically install all plugins.

Use `:Lazy` to check plugin status. Press `q` to close the window.


## ❌ Uninstalling

To completely remove LuckiVim and lazy.nvim, delete the following files and directories:

<details><summary> Linux and macOS </summary>

```sh
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy
rm -f ~/.config/nvim/lazy-lock.json
```

</details>

<details><summary> Windows (PowerShell) </summary>

```powershell
Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim
Remove-Item -Recurse -Force $env:LOCALAPPDATA\nvim-data\lazy -ErrorAction SilentlyContinue
```

</details>

Paths may differ if you changed [XDG](https://specifications.freedesktop.org/basedir/latest/) environment variables.

## 📂 File Structure

```
~/.config/nvim
├── init.lua
└── lua
    ├── config
    │   ├── autocmds.lua
    │   ├── globals.lua
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── options.lua
    └── plugins
        ├── themes.lua
        └── xxx.lua
```
