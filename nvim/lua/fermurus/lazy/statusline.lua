return {
    "nvim-lualine/lualine.nvim",
    name = "lualine",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff' },
                lualine_c = { { 'filename', path = 1 } },
                lualine_x = {},
                lualine_y = { { 'diagnostics', always_visible = true } },
                lualine_z = { 'location' }
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {
                lualine_a = {'hostname'},
                lualine_b = {},
                lualine_c = { { 'buffers', mode = 2 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { { 'tabs', symbols = { modified = '' } } }
            },
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
}
