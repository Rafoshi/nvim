return {
    {
        "ggandor/leap.nvim",
        config = function()
            local leap = require('leap')

            -- Setup default keymaps
            leap.add_default_mappings()

            require('leap').opts.highlight_unlabeled_phase_one_targets = true
        end,
    },
}
