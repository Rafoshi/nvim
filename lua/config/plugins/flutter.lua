return {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim',
    },
    config = function()
        require("flutter-tools").setup {
            widget_guides = {
                enabled = true,
            },
        }
    end,
}
