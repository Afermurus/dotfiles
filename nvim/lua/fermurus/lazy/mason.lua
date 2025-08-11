return {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗"
                        }
                    }
                }
            },
            'mason-org/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
            'saghen/blink.cmp',
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local map = function(keys, func, desc, mode)
                        mode = mode or 'n'
                        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                    end

                    map('rn', vim.lsp.buf.rename, '[R]e[N]ame')
                end
            })

            vim.diagnostic.config({
                --virtual_lines = true,
                virtual_text = true,
                underline = {severity = vim.diagnostic.severity.ERROR},
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "󰅚 ",
                        [vim.diagnostic.severity.WARN] = "󰀪 ",
                        [vim.diagnostic.severity.INFO] = "󰋽 ",
                        [vim.diagnostic.severity.HINT] = "󰌶 ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "ErrorMsg",
                        [vim.diagnostic.severity.WARN] = "WarningMsg",
                    },
                },
            })

            local capabilities = require('blink-cmp').get_lsp_capabilities()

            local servers = {
                clangd = {},
                gopls = {},
                pyright = {},
                lua_ls = {},
                ts_ls = {},
            }

            local ensure_installed = vim.tbl_keys(servers or {})
            vim.list_extend(ensure_installed, {
                'stylua'
            })
            require('mason-tool-installer').setup{ ensure_installed = ensure_installed }
            require('mason-lspconfig').setup{
                ensure_installed = {},
                automatic_installation = false,
                handlers = {
                    function (server_name)
                        local server = servers{server_name} or {}
                        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                        require('lspconfig')[server_name].setup(server)
                    end
                }
            }
        end
    }
