return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
        opts = {
            signs                        = {
                add          = { text = '│' },
                change       = { text = '~' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
            numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
            linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
            word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
            watch_gitdir                 = {
                follow_files = true
            },
            attach_to_untracked          = true,
            current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts      = {
                virt_text = true,
                virt_text_pos = 'right_align', -- 'eol' | 'overlay' | 'right_align'
                delay = 300,
                ignore_whitespace = false,
                virt_text_priority = 100,
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
            sign_priority                = 6,
            update_debounce              = 100,
            status_formatter             = nil,   -- Use default
            max_file_length              = 40000, -- Disable if file is longer than this (in lines)
            preview_config               = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
        },
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>gl', ':Gitsigns toggle_current_line_blame<CR>',
                { noremap = true, silent = true })
            vim.api.nvim_set_keymap('n', '<leader>gld',
                ':Gitsigns toggle_word_diff<CR> :Gitsigns toggle_deleted<CR>:Gitsigns toggle_linehl<CR>',
                { noremap = true, silent = true })
        end
    },
}
