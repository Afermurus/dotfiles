-- Functions
function Switch_buffer()
    local index = vim.fn.input('Index: ')
    if index == "" then
        vim.cmd(":b#")
    else
        vim.cmd(":LualineBuffersJump " .. index)
    end
end

-- Constants
END_MAP = {noremap=true, silent=true}

-- Text manipulation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader><Tab>", "<cmd>lua vim.lsp.buf.format()<CR>", END_MAP)
vim.keymap.set("n", "<leader>y", "\"+y", END_MAP)
vim.keymap.set("n", "<leader>p", "\"+p", END_MAP)

-- Text Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", END_MAP)
vim.keymap.set("n", "<C-u>", "<C-u>zz", END_MAP)
vim.keymap.set({'n','v'}, '¤', '$', END_MAP) --Sv keyboard

-- Navigation
vim.keymap.set('n', '<leader>oe', ':Ex<CR>', END_MAP)
vim.keymap.set('n', '<leader>bs', ':lua Switch_buffer()<CR>', END_MAP)
vim.keymap.set('n', '<leader>bb', ':b#<CR>', END_MAP)
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', END_MAP)
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', END_MAP)
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', END_MAP)
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', END_MAP)

-- Helpthingies
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', END_MAP)
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', END_MAP)


vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({"i", 'v', 'x', 'n'}, '<C-c>', '<Esc>', END_MAP)
vim.keymap.set('n', 'gh', '<nop>')
vim.keymap.set('n', 'g<C-c>', '<nop>')
vim.keymap.set('n', 'gH', '<nop>')


