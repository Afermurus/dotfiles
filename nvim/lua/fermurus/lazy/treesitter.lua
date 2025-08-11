return {
    {
        "nvim-treesitter/nvim-treesitter",
        name = "Treesitter",
        build = { ":TSUpdate" }, --updates parsers
        lazy = false,
        branch = "main",
        config = function()
            require("nvim-treesitter").install({
                "ada", "asm", "bash", "c", "css", "c_sharp", "cmake",
                "comment", "cpp", "css", "csv", "dockerfile", "go", "html",
                "java", "javascript", "json", "lua", "make", "matlab",
                "python", "regex", "rust", "sql", "ssh_config", "typescript", "zig",
                "awk", "doxygen", "git_config", "go_mod", "go_sum", "hyprlang",
                "jinja", "jsonc", "markdown", "markdown_inline", "tmux", "jsx", "tsx",
                "vimdoc", "vim", "xml", "yaml", "zathurarc"
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        after = "nvim-treesitter",
        opts = {
            enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
            multiwindow = true,       -- Enable multiwindow support.
            max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 20, -- Maximum number of lines to show for a single context
            trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20,     -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        }
    }
}
