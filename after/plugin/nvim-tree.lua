require("nvim-tree").setup({
    -- sort_by = "case_sensitive",
    view = {
        width = 45,
    },
    git = {
        ignore = false,
    },
})

vim.keymap.set("n", "<leader>t", ":NvimTreeToggle<cr>")
