return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gg", ":Git<CR>")
        vim.keymap.set("n", "<leader>gp", ":Git pull<CR>")
    end
}
