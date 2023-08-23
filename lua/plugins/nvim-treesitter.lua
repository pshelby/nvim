-- add more treesitter parsers
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
        "hcl",
        "ninja",
        "python",
        "ron",
        "rst",
        "rust",
        "terraform",
        "toml",
        "yaml",
      })
    end
  end,
}
