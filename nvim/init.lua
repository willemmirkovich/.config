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

local plugins = {
	{
		'neovim/nvim-lspconfig', commit = 'a687466cfe8556abb067386d61c8ad6a39df9b75',
		dependencies = {
			{ 'williamboman/mason-lspconfig.nvim', tag = 'v1.12.0' },
			{ 'williamboman/mason.nvim', tag = 'v1.6.2' }
		}
	},
	{
		'nvim-treesitter/nvim-treesitter', commit = 'dfcfdb0e7bcb362c4de1ed7d0015c21957c91ba7'
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		dependencies = { 'nvim-lua/plenary.nvim', tag = '0.1.3' }
	},
	{
		'alexghergh/nvim-tmux-navigation',
		commit = '543f090a45cef28156162883d2412fffecb6b750'
	},
	{
		'akinsho/bufferline.nvim', tag = 'v4.3.0',
		dependencies = { 'nvim-tree/nvim-web-devicons', commit = 'ab899311f8ae00a47eae8e0879506cead8eb1561' }
	},
	{
		'kdheepak/lazygit.nvim', commit = '22e51e03268fabe068a77e2bd316ac25ff2084f9',
		dependencies = { 'nvim-lua/plenary.nvim', tag = '0.1.3' }
	},
	{
		'nmac427/guess-indent.nvim', commit = 'b8ae749fce17aa4c267eec80a6984130b94f80b2'
	}
}
require('lazy').setup(plugins) -- can add opts

-- leader key = Space
vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- tabs -> spaces and 4 spaces by default, will be overidden with guess-indent
vim.g.tabstop = 4
vim.g.expandtab = true

-- colorscheme
-- vim.cmd('colorscheme kanagawa')

-- options

-- default yank to clibboard
vim.opt.clipboard = 'unnamedplus'

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

-- swapfiles
vim.opt.swapfile = false

-- search
vim.opt.smartcase = true

-- TODO: determine if should turn back on, messes up color coord with starship theme
-- vim.opt.termguicolors = true

-- keymaps -> https://neovim.io/doc/user/lua-guide.html#lua-guide-mappings
-- NOTE: ([mode(s)], '[from]', '[to]')

-- all delete operations go to black hole register
vim.keymap.set({'n', 'v'}, 'd', '"_d')

-- all help commands open vertical split
-- NOTE: do not add to normal mode, will slow down 'h' motion
vim.keymap.set('c', 'help', 'vert help')
-- NOTE: below will remap every 'h' to below when typing, doesn't work
-- vim.keymap.set({'c', 'n'}, 'h', 'vert h')

-- navigate buffers in nvim split
vim.keymap.set('n', '<S-l>', ':bnext<CR>')
vim.keymap.set('n', '<S-h>', ':bprevious<CR>')

-- navigate splits & tmux panes
local nvim_tmux_nav = require('nvim-tmux-navigation')
nvim_tmux_nav.setup {
	disable_when_zoomed = true
}
vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

-- telescope keymaps
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
-- NOTE: may be able to include multiple glob patterns here
vim.keymap.set('n', '<leader>fa', ':Telescope find_files find_command=rg,--no-ignore,--hidden,--files,--glob,!.git<CR>')
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, {})

-- bufferline
require('bufferline').setup{
	options = {
		indicator = {
			style = 'underline'
		}
	}
}

-- lazygit
vim.keymap.set('n', '<leader>lg', ':LazyGit<CR>', {})

-- guess-indent
require('guess-indent').setup{}

-- lsp
-- mason
require('mason').setup()

-- mason-lspconfig
require('mason-lspconfig').setup{
	ensure_installed = {
		'lua_ls', -- lua
		'pyright', -- python
		'prosemd_lsp', -- markdown
		'bashls', -- bash
		'dockerls', -- docker
		'docker_compose_language_service', -- docker-compose
		'jsonls', -- json
		'sqlls', -- sql
		'yamlls', -- yaml
	}
}

-- nvim-lspconfig
-- TODO: refactor to either dynamic mason setup or simpler
require('lspconfig').lua_ls.setup{
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
}
require('lspconfig').pyright.setup{}
require('lspconfig').prosemd_lsp.setup{}
-- TODO: configure to look at files without .sh file extension
require('lspconfig').bashls.setup{}
require('lspconfig').dockerls.setup{}
require('lspconfig').docker_compose_language_service.setup{}
require('lspconfig').jsonls.setup{}
require('lspconfig').sqlls.setup{}
require('lspconfig').yamlls.setup{}

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'c', 'lua', 'vim', 'vimdoc', 'query', -- should always be installed
		'python', 'markdown', 'javascript', 'typescript'
	}

}
