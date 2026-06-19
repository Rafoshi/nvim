return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            'saghen/blink.cmp',
            {
                "folke/lazydev.nvim",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilites = capabilities }
            require("lspconfig").pylsp.setup { capabilities = capabilities }

            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local c = vim.lsp.get_client_by_id(args.data.client_id)
                    if not c then return end

                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
                    end

                    map('n', 'gd', vim.lsp.buf.definition, '[G]o to [D]efinition')
                    map('n', 'gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
                    map('n', 'gi', vim.lsp.buf.implementation, '[G]o to [I]mplementation')
                    map('n', 'gr', vim.lsp.buf.references, '[G]o to [R]eferences')
                    map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
                    map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature Help')
                    map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
                    map('n', '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
                    map('n', '<leader>f', function()
                        vim.lsp.buf.format({ async = true })
                    end, '[F]ormat')

                    if vim.bo.filetype == "lua" then
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = args.buf, id = c.id })
                            end,
                        })
                    end
                end,
            })
        end,
    }
}
