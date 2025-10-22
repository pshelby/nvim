# Neovim Configuration with LazyVim

A comprehensive Neovim configuration built on the LazyVim framework, featuring AI/LLM integration, modern development tools, and productivity enhancements.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Plugin Configuration](#plugin-configuration)
- [AI/LLM Integration](#aillm-integration)
- [Key Mappings](#key-mappings)
- [Customizations](#customizations)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)

## Overview

This Neovim configuration is built on top of [LazyVim](https://www.lazyvim.org/), a Neovim setup powered by lazy.nvim to make it easy to customize and extend your config. The configuration includes modern development tools, AI assistance capabilities, and productivity enhancements.

### Base Framework
- **LazyVim**: Provides a solid foundation with sensible defaults
- **Lazy.nvim**: Plugin manager for fast startup times and lazy loading
- **Modular Structure**: Clean separation of configuration concerns

## Features

### Core Development Tools
- **LSP Integration**: Language Server Protocol support with Mason
- **Git Integration**: Advanced git blame and version control features
- **Modern UI**: Enhanced interface with Snacks.nvim utilities
- **Auto Commands**: Intelligent automation for common tasks

### AI/LLM Integration
- **Avante**: AI assistant with Claude/OpenAI integration
- **MCP Hub**: Model Context Protocol for advanced AI workflows
- **Code Generation**: AI-powered code completion and generation
- **Context-Aware Assistance**: Smart suggestions based on your codebase

### Productivity Features
- **Custom Key Mappings**: Optimized shortcuts for common tasks
- **Auto Commands**: Automated workflows and file handling
- **Plugin Ecosystem**: Carefully curated plugins for enhanced productivity

## Prerequisites

Before installing this configuration, ensure you have:

- **Neovim >= 0.9.0** (recommended: latest stable)
- **Git** for cloning repositories and version control
- **A Nerd Font** for proper icon display (recommended: FiraCode Nerd Font)
- **Node.js** (for certain LSP servers and plugins)
- **Python 3** with pip (for Python-based tools)
- **Ripgrep** for fast searching
- **fd** for file finding (optional but recommended)

### System-Specific Requirements

#### macOS
```bash
brew install neovim git ripgrep fd
```

#### Ubuntu/Debian
```bash
sudo apt update
sudo apt install neovim git ripgrep fd-find
```

#### Arch Linux
```bash
sudo pacman -S neovim git ripgrep fd
```

## Installation

### Step 1: Backup Existing Configuration

If you have an existing Neovim configuration, back it up first:

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
mv ~/.local/state/nvim ~/.local/state/nvim.backup
mv ~/.cache/nvim ~/.cache/nvim.backup
```

### Step 2: Clone This Configuration

```bash
git clone <your-repo-url> ~/.config/nvim
```

### Step 3: Start Neovim

```bash
nvim
```

On first startup, LazyVim will automatically:
- Install the Lazy.nvim plugin manager
- Download and install all configured plugins
- Set up LSP servers and tools

This process may take a few minutes depending on your internet connection.

### Step 4: Install Additional Tools

Some plugins may require additional tools. Run these commands in Neovim:

```vim
:checkhealth
:Mason
```

Use `:checkhealth` to identify any missing dependencies, and `:Mason` to install additional LSP servers, formatters, and linters.

## Plugin Configuration

### Core Plugins

All plugin configurations are located in `lua/plugins/`. Here's an overview of the key plugins:

#### Avante (`lua/plugins/avante.lua`)
AI assistant integration with support for:
- **Claude (Anthropic)**: Advanced reasoning and code analysis
- **OpenAI GPT**: Code generation and explanations
- **Custom Providers**: Extensible AI backend support

**Key Features:**
- Inline code suggestions
- Context-aware completions
- Code explanation and documentation
- Refactoring assistance

#### MCP Hub (`lua/plugins/mcphub.lua`)
Model Context Protocol integration for:
- **Advanced AI Workflows**: Structured AI interactions
- **Context Management**: Better AI understanding of your codebase
- **Plugin Ecosystem**: Integration with MCP-compatible tools

#### Git Blame (`lua/plugins/git-blame.lua`)
Advanced git integration featuring:
- **Inline Blame**: See commit information directly in the editor
- **Commit Details**: Quick access to commit messages and authors
- **History Navigation**: Browse file history efficiently

#### Snacks (`lua/plugins/snacks.lua`)
Utility collection providing:
- **UI Enhancements**: Improved notifications and interfaces
- **Productivity Tools**: Quick actions and shortcuts
- **Custom Functions**: Extended Neovim functionality

#### Mason Workaround (`lua/plugins/mason-workaround.lua`)
Fixes and enhancements for LSP server management:
- **Compatibility Fixes**: Resolves common Mason issues
- **Enhanced Installation**: Improved LSP server setup
- **Stability Improvements**: More reliable tool management

### Adding New Plugins

To add a new plugin, create a file in `lua/plugins/` or use the provided template in `lua/plugins/example.lua`:

```lua
-- lua/plugins/your-plugin.lua
return {
  "author/plugin-name",
  config = function()
    -- Plugin configuration
  end,
  dependencies = {
    -- Dependencies if any
  },
  event = "VeryLazy", -- Load timing
}
```

## AI/LLM Integration

### Avante Configuration

The Avante plugin provides powerful AI assistance. To configure your API keys:

1. **Claude (Anthropic)**:
   ```bash
   export ANTHROPIC_API_KEY="your_api_key_here"
   ```

2. **OpenAI**:
   ```bash
   export OPENAI_API_KEY="your_api_key_here"
   ```

3. **Environment File**: Create `~/.config/nvim/.env`:
   ```
   ANTHROPIC_API_KEY=your_anthropic_key
   OPENAI_API_KEY=your_openai_key
   ```

### MCP Hub Features

The MCP Hub integration provides:
- **Server Management**: Start/stop MCP servers as needed
- **Resource Access**: Direct access to MCP resources
- **Tool Integration**: Use MCP tools within Neovim

### AI Workflow Examples

1. **Code Generation**:
   - Select code block
   - Use AI to generate similar functions
   - Get explanations for complex logic

2. **Refactoring**:
   - Highlight code to refactor
   - Get AI suggestions for improvements
   - Apply changes with confidence

3. **Documentation**:
   - Generate docstrings automatically
   - Create README sections
   - Explain complex algorithms

## Key Mappings

Custom key mappings are defined in `lua/config/keymaps.lua`. Here are some highlights:

### General Navigation
- `<leader>` key is set to `<Space>`
- Standard LazyVim keybindings are preserved
- Additional custom mappings for AI features

### AI Integration Shortcuts
- **Avante Commands**: Quick access to AI assistance
- **MCP Tools**: Integrated AI workflow shortcuts
- **Code Actions**: AI-powered code improvements

### Git Integration
- **Blame Toggle**: Quick git blame information
- **Commit Navigation**: Browse git history
- **Diff Views**: Compare file changes

For a complete list of keybindings, run `:help` in Neovim or check the LazyVim documentation.

## Customizations

### Options (`lua/config/options.lua`)
Custom Neovim options including:
- Editor behavior settings
- UI preferences
- Performance optimizations

### Auto Commands (`lua/config/autocmds.lua`)
Automated behaviors for:
- File type detection
- Auto-formatting
- Buffer management
- Project-specific settings

### LazyVim Configuration (`lazyvim.json`)
LazyVim-specific settings:
- Colorscheme preferences
- Plugin defaults
- Feature toggles

## Troubleshooting

### Common Issues

#### Plugin Loading Errors
1. Run `:Lazy check` to verify plugin status
2. Use `:Lazy clean` to remove unused plugins
3. Run `:Lazy update` to update all plugins

#### LSP Server Issues
1. Check `:checkhealth` for missing dependencies
2. Use `:Mason` to reinstall problematic servers
3. Restart Neovim after installing new tools

#### AI Integration Problems
1. Verify API keys are set correctly
2. Check network connectivity
3. Review plugin logs for error messages

#### Performance Issues
1. Check startup time with `nvim --startuptime startup.log`
2. Disable unnecessary plugins temporarily
3. Review lazy loading configuration

### Getting Help

1. **Check Health**: Run `:checkhealth` for diagnostic information
2. **Plugin Docs**: Use `:help plugin-name` for specific plugin help
3. **LazyVim Docs**: Visit [lazyvim.org](https://www.lazyvim.org/) for framework documentation
4. **Community**: Join the LazyVim Discord or GitHub discussions

### Log Files

Important log locations:
- Neovim logs: `~/.local/state/nvim/log`
- Plugin logs: `~/.local/share/nvim/lazy/plugin-name/`
- LSP logs: Available via `:LspLog`

## Contributing

### Adding Plugins

1. Use the template in `lua/plugins/example.lua`
2. Follow the existing naming conventions
3. Add appropriate documentation
4. Test thoroughly before committing

### Plugin Template

The `lua/plugins/example.lua` file serves as a template for new plugin configurations:

```lua
-- Example plugin configuration
-- Copy this file and modify for new plugins
return {
  -- Plugin specification
  "author/plugin-name",
  
  -- Plugin configuration
  config = function()
    require("plugin-name").setup({
      -- Configuration options
    })
  end,
  
  -- Loading strategy
  event = "VeryLazy",
  
  -- Dependencies
  dependencies = {
    "dependency/plugin",
  },
  
  -- Conditional loading
  cond = function()
    return true -- Add conditions here
  end,
}
```

### Best Practices

1. **Lazy Loading**: Use appropriate events and conditions
2. **Documentation**: Comment complex configurations
3. **Testing**: Verify changes don't break existing functionality
4. **Performance**: Monitor startup time impact
5. **Compatibility**: Ensure compatibility with LazyVim

### Submitting Changes

1. Fork the repository
2. Create a feature branch
3. Make your changes with appropriate tests
4. Update documentation as needed
5. Submit a pull request with detailed description

## File Structure

```
~/.config/nvim/
├── init.lua                     # Main configuration entry point
├── lazyvim.json                 # LazyVim configuration
├── lazy-lock.json              # Plugin version lock file
├── lua/
│   ├── config/
│   │   ├── autocmds.lua        # Auto commands
│   │   ├── keymaps.lua         # Key mappings
│   │   ├── lazy.lua            # Lazy.nvim setup
│   │   └── options.lua         # Neovim options
│   └── plugins/
│       ├── avante.lua          # AI assistant integration
│       ├── example.lua         # Plugin template
│       ├── git-blame.lua       # Git blame functionality
│       ├── mason-workaround.lua # LSP server fixes
│       ├── mcphub.lua          # MCP integration
│       └── snacks.lua          # Utility functions
└── README_sonnet4.md           # This documentation
```

## Resources

### Documentation
- [LazyVim Documentation](https://www.lazyvim.org/)
- [Neovim Documentation](https://neovim.io/doc/)
- [Lazy.nvim Plugin Manager](https://github.com/folke/lazy.nvim)

### Community
- [LazyVim Discord](https://discord.gg/lazyvim)
- [Neovim Reddit](https://www.reddit.com/r/neovim/)
- [LazyVim GitHub Discussions](https://github.com/LazyVim/LazyVim/discussions)

### Related Projects
- [Avante.nvim](https://github.com/yetone/avante.nvim)
- [MCPHub](https://github.com/pshelby/mcphub.nvim)
- [Mason.nvim](https://github.com/williamboman/mason.nvim)

---

**Last Updated**: 2025

**Configuration Version**: LazyVim + Custom Extensions

**Compatibility**: Neovim >= 0.9.0
