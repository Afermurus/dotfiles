return{
	"nvim-treesitter/nvim-treesitter",
	name = "Treesitter",
	build = ":TSUpdate", --updates parsers
	event = {"BufReadPost", "BufNewFile"}, --Lazy loading on specific events
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"ada", "asm", "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "csv", "dockerfile", "go", "html", "java", "javascript", "json", "lua", "make", "matlab", "python", "regex", "rust", "sql", "ssh_config", "typescript", "zig",
			},
			highlight = {enable = true, additional_vim_regex_highlighting = false,},
			indent = {enable = true},
		})
	end,
	}
