# Neovim Configuration

This repository contains my custom Neovim configuration, designed for a modern and efficient development experience. It leverages the power of Lua for configuration and includes a variety of plugins to enhance productivity.

## Features

- **Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for fast and efficient plugin management.
- **LSP Support**: Configured with `nvim-lspconfig` for seamless language server integration. Additionally, `mason.nvim` is used to automatically install and manage LSP servers, formatters, and linters.
- **Autocompletion**: Powered by `nvim-cmp` with support for buffer, path, and LSP completions.
- **Treesitter**: Syntax highlighting, indentation, and text objects with `nvim-treesitter`.
- **File Explorer**: Integrated `nvim-tree` for file navigation.
- **Git Integration**: Git signs and commands with `gitsigns.nvim` and `lazygit.nvim`.
- **UI Enhancements**: Custom status line with `lualine.nvim`, bufferline, and themes like `night-owl.nvim`.
- **Code Formatting**: Automatic formatting with `conform.nvim`.
- **Linting**: Configured with `nvim-lint` for various languages.
- **Session Management**: Save and restore sessions with `auto-session`.
- **Keybinding Helper**: `which-key.nvim` for discovering keybindings.
- **Other Utilities**: Commenting, autopairs, surround, and more.

## Installation

1. Clone this repository into your Neovim configuration directory:
   ```bash
   git clone <repository-url> ~/.config/nvim
   ```
2. Open Neovim, and lazy.nvim will automatically install itself and the configured plugins.
3. Restart Neovim to apply the configuration.

## External Tools required

1. Lazy Git
2. EsLint
3. Prettier

## Customization

You can customize the configuration by editing the files in the `lua/MrLmao` directory. Key areas include:

- **Core settings**: `lua/MrLmao/core`
- **Plugins**: `lua/MrLmao/plugins`

## Contributing

Feel free to fork this repository and submit pull requests for improvements or new features.

## License

This configuration is open-source and available under the MIT License.
