return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "windwp/nvim-autopairs",
        "onsails/lspkind.nvim"
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        local lspkind = require("lspkind")

        local kind_formatter = lspkind.cmp_format {
            mode = "symbol_text",
            menu = {
                nvim_lsp = "[LSP]",
                buffer = "[buf]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            },
        }

        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls", --lua
            },
            handlers = {
                function(server_name) --default
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        },
                    }
                end,
            }
        })

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            completion = { completeopt = "menu,menuone,noinsert" },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<Tab>'] = function(fallback)
                    if cmp.visible() then
                        cmp.confirm({
                            select = true,
                        })
                    else
                        fallback()
                    end
                end,
                ["<C-Space>"] = cmp.mapping.complete(),
                ['<C-h>'] = function(fallback)
                    if cmp.visible() then
                        cmp.open_docs()
                    else
                        fallback()
                    end
                end,
                ['<C-q>'] = function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        fallback()
                    end
                end,
                ['<C-d>'] = function(fallback)
                    if cmp.visible_docs() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end,
                ['<C-u>'] = function(fallback)
                    if cmp.visible_docs() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end,
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lua' },
                { name = 'nvim_lsp' },
                { name = 'buffer',  keyword_lenght = 4, max_item_count = 5 },
                { name = 'path',    keyword_lenght = 6, max_item_count = 3 },
                { name = 'luasnip' },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    -- Below is the default comparitor list and order for nvim-cmp
                    cmp.config.compare.offset,
                    -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                }
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                expandable_indicator = true,
                format = function(entry, vim_item)
                    -- Lspkind setup for icons
                    vim_item = kind_formatter(entry, vim_item)
                    return vim_item
                end,
            },
            view = {
                docs = { auto_open = false },
                entries = { selection_order = "near_cursor" },
                view = "custom"
            },
            window = {
                completion = cmp.config.window.bordered({
                    border = 'none',     -- Rounded border for the completion window
                    winhighlight = 'Normal:CmpNormal,FloatBorder:CmpBorder', -- Custom highlight groups for Normal and Border
                    winblend = 15,                                           -- Slight transparency (15 out of 255)
                    zindex = 100,                                            -- Higher value ensures the completion window is on top
                    scrolloff = 10,                                          -- Keep 10 lines visible while scrolling through the completion
                    col_offset = 0,                                          -- Offset by 1 column to the right of the cursor
                    side_padding = 0,                                        -- Add 5 columns of padding on each side of the window
                }),
                documentation = cmp.config.window.bordered({
                    border = 'none',                                               -- Rounded border for documentation window
                    winhighlight = 'Normal:CmpDocNormal,FloatBorder:CmpDocBorder', -- Custom highlight groups
                    winblend = 20,                                                 -- Slightly more transparent (20 out of 255)
                    zindex = 50,                                                   -- Lower zindex for the documentation window, behind completion
                    max_width = 200,
                    max_height = 130
                })
            },
            experimental = { ghost_text = true },
        })

        -- `/` cmdline setup.
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- `:` cmdline setup.
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
    end
}
