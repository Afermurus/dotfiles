return {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", name = "fzf" }
    },
    config = function()
        local actions = require('telescope.actions') -- Not needed?
        local open_with_trouble = require('trouble.sources.telescope').open
        local add_to_trouble = require('trouble.sources.telescope').add -- Not needed?
        require('telescope').setup({
            extensions = { fzf = {} },
            pickers = {
                builtin = { theme = "dropdown" }
            },
            defaults = {
                mappings = {
                    i = {['<C-t>'] = open_with_trouble},
                    n = {['<C-t>'] = open_with_trouble}
                }
            }
        })

        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, END_MAP)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, END_MAP)
        vim.keymap.set('n', '<leader>fw', builtin.grep_string, END_MAP)
        vim.keymap.set('n', '<leader>fp', builtin.builtin, END_MAP)
        vim.keymap.set('n', '<leader>fb', builtin.buffers, END_MAP)
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, END_MAP)
        vim.keymap.set('n', '<leader>fc', builtin.colorscheme, END_MAP)
        -- Language stuff
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, END_MAP)
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, END_MAP)
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, END_MAP)
        vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, END_MAP)
        vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols, END_MAP)
        vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, END_MAP)
        -- TODO: Fix buffer split



    end
}
