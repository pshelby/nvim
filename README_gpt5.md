# Neovim Configuration (LazyVim + lazy.nvim + AI / MCP Enhancements)

This repository contains a modern, batteries-included Neovim setup built on top of [lazy.nvim](https://github.com/folke/lazy.nvim) and the [LazyVim](https://github.com/LazyVim/LazyVim) starter ecosystem, extended with AI tooling (Avante + MCP Hub) and curated language/server configurations.

---
## Table of Contents
1. Features Overview
2. Requirements
3. Installation & First Launch
4. Directory Structure
5. Plugin & Configuration Architecture
6. Core Plugins (LazyVim Base + Extras)
7. Custom / Added Plugins
8. AI & MCP Integration (Avante + mcphub.nvim)
9. Language Servers, Formatters & Tools (LSP / Mason / Treesitter)
10. UI / UX Enhancements
11. Commands & Keymaps (Extension Points)
12. Formatting & Code Style
13. Updating / Managing Plugins
14. Extending This Setup (Adding Your Own Plugins)
15. Troubleshooting
16. FAQ
17. Credits & License

---
## 1. Features Overview
- Fast, lazy-loaded plugin management via `lazy.nvim`.
- Opinionated defaults from LazyVim with optional language “extras” enabled (JSON, Python, Rust, SQL, Terraform, TOML, YAML, Docker, Markdown, Git, Zig, Copilot AI, etc.).
- AI-assisted coding through `yetone/avante.nvim` with model provider configuration and dynamic system prompts powered by active MCP servers.
- MCP (Model Context Protocol) integration via `ravitemer/mcphub.nvim` to expose local structured tool capabilities to AI models.
- Enhanced fuzzy finding / pickers through LazyVim’s Telescope defaults and custom “Snacks” picker config with hidden + ignored file visibility.
- Git annotation with lightweight `git-blame.nvim`.
- Deterministic plugin versions locked in `lazy-lock.json` (auto-maintained by lazy.nvim).
- Clean extension surface for adding more plugins in `lua/plugins/`.

---
## 2. Requirements
| Component | Minimum Version / Notes |
|-----------|-------------------------|
| Neovim    | 0.9+ (recommended: latest stable) |
| Git       | Required for cloning plugins |
| Node.js   | Needed for some LSP servers / Avante build (if using token counting) |
| Make      | Optional (for `avante.nvim` build step) |
| npm       | Used to globally install `mcp-hub` (see mcphub plugin) |

Optional: language toolchains (Python, Rust toolchain, etc.) for LSP servers to work fully.

---
## 3. Installation & First Launch
```bash
# Clone into your Neovim config directory
# NOTE: This repo is structured as a full config, so clone directly:
 git clone https://github.com/your-user/your-nvim-config.git ~/.config/nvim

# Start Neovim (lazy.nvim will bootstrap automatically)
 nvim

# The first launch will:
#  - Bootstrap lazy.nvim
#  - Install LazyVim + specified plugins
#  - Sync language servers/tools via Mason (as they are used)
```
If something fails during the first run (e.g. network issues), run `:Lazy sync` inside Neovim once connectivity is restored.

---
## 4. Directory Structure
```
.
├── init.lua                # Entry point: bootstraps lazy config
├── lazyvim.json            # LazyVim extras configuration snapshot
├── lazy-lock.json          # Generated lockfile (do not hand-edit)
├── stylua.toml             # Lua formatter settings
├── README.md               # Original LazyVim template README
├── README_gpt5.md          # This comprehensive README
├── lua/
│   ├── config/
│   │   ├── lazy.lua        # lazy.nvim setup + performance options
│   │   ├── options.lua     # Additional vim options (currently minimal)
│   │   ├── keymaps.lua     # Space for custom keymaps
│   │   └── autocmds.lua    # Space for custom autocmds
│   └── plugins/            # All custom (or overriding) plugin specs
│       ├── avante.lua
│       ├── snacks.lua
│       ├── mcphub.lua
│       ├── git-blame.lua
│       ├── mason-workaround.lua
│       └── example.lua     # Fully disabled by early `if true then return {}` guard
```

---
## 5. Plugin & Configuration Architecture
- `lua/config/lazy.lua` sets up `lazy.nvim`, registers specs, and defines performance tweaks (disabling unused runtimepath plugins).
- Each file under `lua/plugins/` returns a Lua table spec consumed by lazy.nvim.
- Specs can:
  - Add new plugins
  - Override existing LazyVim plugin options
  - Adjust dependencies
  - Lazily configure tools via `opts` or `config = function()`
- `lazyvim.json` tracks installed extras and internal LazyVim metadata (e.g. news markers, version snapshot).

### Bootstrapping Flow
1. `init.lua` → requires `config.lazy`.
2. `config.lazy` ensures `lazy.nvim` is present (`git clone` if missing) and prepends it to `runtimepath`.
3. `lazy.setup()` loads base spec + local plugin specs.
4. LazyVim core defaults apply; local overrides merge in (non-destructively unless explicitly replaced).

---
## 6. Core Plugins (LazyVim Base + Extras)
The base LazyVim distribution already includes:
- UI: lualine, bufferline, treesitter-based folding, etc.
- Editing: autopairs, surround, comment, gitsigns, which-key, etc.
- Navigation: telescope, better quickfix, improved motions.
- Completion: nvim-cmp stack
- LSP: mason.nvim + lspconfig orchestration + UI enhancements

### Enabled Extras (from `lazyvim.json`)
| Extra | Purpose |
|-------|---------|
| `ai.copilot` | GitHub Copilot integration |
| `lang.docker` | Dockerfile syntax & tools |
| `lang.git` | Git-related enhancements (diff, browsing) |
| `lang.json` | JSON language tooling + schemas |
| `lang.markdown` | Markdown preview/enhancements |
| `lang.python` | Python LSP, formatting, debug helpers |
| `lang.rust` | Rust analyzer integration |
| `lang.sql` | SQL language tooling |
| `lang.terraform` | Terraform HCL support |
| `lang.toml` | TOML parsing & tooling |
| `lang.yaml` | YAML schema + lsp improvements |
| `lang.zig` | Zig language support |

These extras automatically configure Treesitter parsers, mason tools, and LSP servers where appropriate.

---
## 7. Custom / Added Plugins
### `yetone/avante.nvim` (lua/plugins/avante.lua)
AI assistant with support for multi-provider backends. Configured providers:
- Claude: model `claude-sonnet-4-20250514`
- OpenAI: model `gpt-5` with `temperature = 1`
Dynamic `system_prompt` and `custom_tools` are functions that query the active MCP Hub state ensuring real-time tool awareness. Optional `build = "make"` enables token counting features if dependencies are present.

### `folke/snacks.nvim` (lua/plugins/snacks.lua)
Configures pickers (files / grep / explorer sources) to include `hidden` and `ignored` files for more exhaustive project searching.

### `ravitemer/mcphub.nvim` (lua/plugins/mcphub.lua)
Integrates the MCP Hub to expose local tools to AI agents.
- Installs a global Node.js binary: `mcp-hub`
- `auto_approve = true` (automatically accepts tool execution requests)
- Avante extension: exposes MCP prompts as `/slash` commands inside the AI UI.

### `f-person/git-blame.nvim` (lua/plugins/git-blame.lua)
Lightweight inline blame annotations. Toggle via built-in commands (see plugin docs) — included with default settings.

### Mason Version Workaround (lua/plugins/mason-workaround.lua)
Pins `mason.nvim` and `mason-lspconfig.nvim` to compatible `^1.0.0` versions due to an upstream LazyVim issue (see comment link). Ensures stability while upstream versions evolve.

### `example.lua`
Template demonstrating overrides (colorscheme, lualine tweaks, nvim-cmp sources, treesitter parser extension, etc.). Fully disabled at top for cleanliness:
```lua
if true then return {} end
```
Use it as a learning reference.

---
## 8. AI & MCP Integration
### Avante + MCP Hub Synergy
Avante’s `system_prompt` calls into `mcphub` each time it constructs a message, embedding live server/tool state. This enables AI-driven workflows (e.g. structured tool execution, dynamic slash commands) without stale introspection.

### Adding New MCP Servers
Install or configure additional MCP servers at the system level; `mcphub.nvim` will surface them if active. Adjust `mcphub` setup in `mcphub.lua` for approval model or extension behaviors.

---
## 9. Language Servers, Formatters & Tools
### Mason
Specified tools (from extras + any custom ensures) are auto-installed on demand. You can manually invoke:
```:Mason``` to open the UI

### Treesitter
Language parsers are primarily provisioned via LazyVim + its extras. You can extend explicitly by adding a plugin spec:
```lua
{
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, { "go", "graphql" })
  end,
}
```

### LSP Customization
Override or add servers in a new spec file:
```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        gopls = { analyses = { unusedparams = true }, staticcheck = true },
      },
    },
  },
}
```

---
## 10. UI / UX Enhancements
- LazyVim base supplies statusline, bufferline, notifications, better diagnostics, etc.
- `snacks.nvim` broadens search context by including hidden and ignored files.
- Animation disabled globally via `vim.g.snacks_animate = false` (see `options.lua`).

---
## 11. Commands & Keymaps (Extension Points)
Currently no custom user keymaps are defined (see `lua/config/keymaps.lua`). LazyVim already exposes a rich set (check `:LazyExtras` documentation or upstream keymap file). Add your own like:
```lua
vim.keymap.set("n", "<leader>xx", function()
  print("Hello from custom map")
end, { desc = "My Custom Action" })
```
Autocmd examples can be added in `autocmds.lua`:
```lua
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.lua",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
```

---
## 12. Formatting & Code Style
- Lua formatting: `stylua` using `stylua.toml` (2-space indent, width 120).
- Additional formatters installed via Mason depending on language (e.g. `flake8`, `shfmt`, etc., if you add them in a spec like the example template shows).

---
## 13. Updating / Managing Plugins
Inside Neovim:
```vim
:Lazy            " Open the plugin UI
:Lazy sync       " Install/update missing plugins & clean removed
:Lazy check      " Check for updates (also auto if checker.enabled)
:Lazy update     " Apply available updates
```
Because `checker.enabled = true` (see `lazy.lua`), update checks occur periodically (notifications disabled by config: `notify = false`).

To update lockfile after manual edits or new plugins: run `:Lazy sync`.

---
## 14. Extending This Setup (Adding Your Own Plugins)
Create a new file under `lua/plugins/`, e.g. `lua/plugins/my-plugin.lua`:
```lua
return {
  {
    "tpope/vim-surround",  -- simple add
  },
  {
    "nvim-lualine/lualine.nvim", -- override existing
    opts = function(_, opts)
      opts.options.theme = "auto"
    end,
  },
}
```
Lazy.nvim automatically loads every spec file in that directory at startup — no further registration required.

---
## 15. Troubleshooting
| Issue | Possible Cause | Fix |
|-------|----------------|-----|
| `lazy.nvim` failed to clone | Network / Git blocked | Re-run `nvim` after network recovers |
| LSP server not starting | Binary not installed | Open `:Mason`, install manually |
| AI model errors | API keys / env not configured | Export required environment variables (depends on provider) |
| MCP tools not visible | Hub not installed globally | Ensure `npm install -g mcp-hub@latest` succeeded |
| Strange Mason behavior | Version drift | Confirm `mason-workaround.lua` still valid or adjust versions |

Debug tips:
```vim
:messages
:checkhealth
:Lazy log
```

---
## 16. FAQ
**Q: How do I change the colorscheme?**
Add a spec overriding LazyVim core or include a theme plugin and set `colorscheme` in the `LazyVim` opts.

**Q: Where do I put environment variables for AI providers?**
Export them in your shell profile before launching Neovim (`~/.zshrc`, `~/.bashrc`, etc.).

**Q: Can I disable an included plugin?**
Yes. Add a spec: `{ "plugin/name", enabled = false }`.

**Q: How do I inspect generated runtime options?**
Use `:lua =vim.opt.rtp` or `:Lazy profile`.

---
## 17. Credits & License
- Base scaffold: [LazyVim](https://github.com/LazyVim/LazyVim)
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
- AI: [Avante](https://github.com/yetone/avante.nvim)
- MCP Integration: [mcphub.nvim](https://github.com/ravitemer/mcphub.nvim)
- Git Blame: [git-blame.nvim](https://github.com/f-person/git-blame.nvim)

Licensed under the repository’s LICENSE file.

---
### Quick Start Recap
```bash
git clone <this-repo> ~/.config/nvim
nvim  # Sit back and let lazy.nvim install everything
```
Enjoy a powerful, extensible Neovim environment with AI and structured tool integration.

