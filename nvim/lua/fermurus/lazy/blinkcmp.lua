return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        'rafamadriz/friendly-snippets',
        {
            'L3MON4D3/LuaSnip',
            version = '2.*',
            build = (function()
                return 'make install_jsregexp'
            end)(),
            opts = {},
        },
        'folke/lazydev.nvim'
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = { preset = 'default' },
        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = 'mono'
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            -- Full word matching if cursor in middle of word
            keyword = { range = 'full' },
            -- Show documentation when selecting a completion item
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 1000,
                update_delay_ms = 500,
            },
            -- What's displayd in cmp menu
            menu = {
                draw = {
                    columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'source_id' } },
                },
            },
            list = {
                selection = {
                    preselect = false,
                    auto_insert = false,
                }
            },
            -- Display a preview of the selected item on the current line
            ghost_text = { enabled = true },
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            per_filetype = {
                lua = { 'lazydev', inherit_defaults = true }
            },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
                cmdline = {
                    -- ignores cmdline completions when executing shell commands
                    enabled = function()
                        return vim.fn.getcmdtype() ~= ':' or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
                    end
                },
                path = {
                    opts = {
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    },
                },
            },
        },
        snippets = { preset = 'luasnip'},

        -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
        -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
        -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
        --
        -- See the fuzzy documentation for more information
        fuzzy = {
            implementation = "prefer_rust_with_warning",
            sorts = {
                'score',
                'sort_text',
                'label'
            }
        },

        -- Helper for arguments and docs when setting arguments
        signature = {
            enabled = true,
            trigger = { show_on_insert = true, }
        },
    },
    opts_extend = { "sources.default" }
}
