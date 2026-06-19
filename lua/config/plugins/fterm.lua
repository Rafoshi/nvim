return {
    'numToStr/FTerm.nvim',
    config = function()
        require('FTerm').setup({
            border = 'double',
            cmd = 'zsh',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        })

        -- Keymaps
        vim.keymap.set('n', '<leader><C-i>', '<CMD>lua require("FTerm").toggle()<CR>')
    end
}
