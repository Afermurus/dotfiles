-- TODO: fix good colors pls!
function ColorMyPencils(color)
    color = color or "monokai-pro"
    vim.cmd.colorscheme(color)

--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "loctvl842/monokai-pro.nvim",
        name = "monokai",
        lazy = false,
        priority = 1000,
        config = function()
            require('monokai-pro').setup({
                background_clear = {
                    "float_win"
                },
            })
        end,
        inc_search = "background",
    },
    {
        --Läs genom hjälp grejen hade bra grejer
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        priority = 1000,
        config = function()
            require('kanagawa').setup({
                compile = false, -- enable compiling the colorscheme
                undercurl = false, -- enable undercurls
                commentStyle = { italic = true }, --Comments
                functionStyle = { bold = true }, --functions()
                keywordStyle = { italic = true }, --if , else, while etc
                statementStyle = { bold = true }, -- retrun break etc
                typeStyle = {},
                transparent = false, -- do not set background color
                dimInactive = true, -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {     -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                --Themes are wave dragon and lotus
                theme = "dragon", -- Load "wave" theme when 'background' option is not set
                background = { -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                },
            })
        end
    },
    {
        "ellisonleao/gruvbox.nvim",
        name = "gruvbox",
        config = function()
            require("gruvbox").setup({
                terminal_colors = true,     -- add neovim terminal colors
                undercurl = true,
                underline = false,
                bold = true,
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = true,
                invert_selection = false,
                invert_signs = false,
                invert_tabline = false,
                invert_intend_guides = false,
                inverse = true,     -- invert background for search, diffs, statuslines and errors
                contrast = "",      -- can be "hard", "soft" or empty string
                palette_overrides = {},
                overrides = {},
                dim_inactive = false,
                transparent_mode = false,
            })
        end,
    },
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm",            -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true,         -- Enable this to disable setting the background color
                terminal_colors = true,     -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark",     -- style for sidebars, see below
                    floats = "dark",       -- style for floating windows
                },
            })
        end
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require('rose-pine').setup({
                disable_background = true,
                styles = {
                    italic = false,
                },
            })

            ColorMyPencils();
        end
    },

    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = {},
        config = function()
            ColorMyPencils()
        end
    },

}
