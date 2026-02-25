# LuckiVim

LuckiVim is a clean and modular Neovim configuration powered by lazy.nvim.  
It provides a lightweight and organized setup that is easy to extend and customize.

## ✨ Features

- Clean modular Lua structure  
- Powered by lazy.nvim  
- Fast startup  
- Separated config (options, keymaps, autocmds)  
- TokyoNight theme included  

## ⚡ Requirements

- Neovim >= 0.9
- Git
- Nerd Font (optional but recommended)

## 🚀 Getting Started

### Install LuckiVim

- Make a backup of your current Neovim files:

  ```sh
  mv ~/.config/nvim ~/.config/nvim.bak
  mv ~/.local/share/nvim ~/.local/share/nvim.bak
  ```

- Clone the repository

  ```sh
  git clone https://github.com/LuckiBit/LuckiVim.git ~/.config/nvim
  ```

- Remove the `.git` folder, so you can add it to your own repo later

  ```sh
  rm -rf ~/.config/nvim/.git
  ```

- Start Neovim!

  ```sh
  nvim
  ```

On first launch, lazy.nvim will automatically install all plugins.

## ❌ Uninstalling

To completely remove LuckiVim and lazy.nvim, delete the following files and directories:

- Remove LuckiVim configuration:

  ```sh
  rm -rf ~/.config/nvim
  ```

- Remove lazy.nvim plugin data:

  ```sh
  rm -rf ~/.local/share/nvim/lazy
  ```

- Remove lazy.nvim state:

  ```sh
  rm -rf ~/.local/state/nvim/lazy
  ```

- Remove lazy lockfile:

  ```sh
  rm -f ~/.config/nvim/lazy-lock.json
  ```

> Paths may differ if you changed XDG environment variables.

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
