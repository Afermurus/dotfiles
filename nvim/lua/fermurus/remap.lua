-- Functions
function Search_replace()
    local old = vim.fn.input("old: ")
    local new = vim.fn.input("New: ")
    if old == "" or new == "" then
        return
    else
        vim.cmd(string.format("%%s/%s/%s/g", old, new))
    end
end

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
vim.keymap.set('n', '<leader>sr', ':lua Search_replace()<CR>', END_MAP)

-- Text Navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz", END_MAP)
vim.keymap.set("n", "<C-u>", "<C-u>zz", END_MAP)
vim.keymap.set({'n','v'}, '¤', '$', END_MAP) --Sv keyboard

-- Navigation
vim.keymap.set('n', '<leader>oe', ':Ex<CR>', END_MAP)
vim.keymap.set('n', '<leader>bs', ':lua Switch_buffer()<CR>', END_MAP)
vim.keymap.set('n', '<leader>bb', ':b#<CR>', END_MAP)
vim.keymap.set('n', '<leader>bd', ':bd<CR>', END_MAP)

-- Helpthingies
vim.keymap.set('n', '<leader>gd', '<cmd>Telescope lsp_definitions<CR>', END_MAP)


vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({"i", 'v', 'x', 'n'}, '<C-c>', '<Esc>', END_MAP)
vim.keymap.set('n', 'gh', '<nop>')
vim.keymap.set('n', 'g<C-c', '<nop>')
vim.keymap.set('n', 'gH', '<nop>')


