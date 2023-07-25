-- bootstrap lazy package manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim', tag = '0.1.3' }
	}
}
require('lazy').setup(plugins) -- can add opts

-- leader key = Space
vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- numbering
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- remove comment leader on new lines
-- NOTE: vim.opt.formatoptions = ... does not work, needs autocmd
-- fix: https://github.com/neovim/neovim/issues/14963#issuecomment-873338847
-- discussion: https://stackoverflow.com/questions/6076592/vim-set-formatoptions-being-lost
vim.api.nvim_create_autocmd({'FileType'}, {
	pattern = '*',
	command = 'set formatoptions-=c formatoptions-=r formatoptions-=o'
})

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

-- telescope keymaps
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})
