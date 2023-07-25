-- leader key = Space
vim.g.leader = ' '

-- numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.formatoptions = { c = false, r = false, o = false }

-- search
vim.opt.smartcase = true

-- keymaps -> https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings
-- NOTE: ([mode(s)], '[from]', '[to]')
-- all delete operations go to black hole register
vim.keymap.set({'n', 'v'}, 'd', '"_d')

-- navigate buffers in nvim split
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')

-- navigate splits (after navigating tmux splits)
-- TODO: need to get new package for tmux/nvim navigation
-- vim.keymap.set('n', '<C-h>', '<C-w>h')
-- vim.keymap.set('n', '<C-j>', '<C-w>j')
-- vim.keymap.set('n', '<C-k>', '<C-w>k')
-- vim.keymap.set('n', '<C-l>', '<C-w>l')
-- vim.keymap.set('n', '<C-d>', '<C-w>q')

