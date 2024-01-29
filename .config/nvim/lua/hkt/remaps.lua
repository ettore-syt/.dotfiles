vim.g.mapleader = (' ')
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- autoformat using the lsp
-- vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)

-- in visual mode, J and K move lines around
vim.keymap.set('v', 'J', ':m \'>+1<CR>gv=gv')
vim.keymap.set('v', 'K', ':m \'<-2<CR>gv=gv')

-- keep cursor in the middle of the page while scrolling half-pages
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- keep searchterms in the middle
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- yanks go in the clipboard if prefixed by the leader key, y works in vim only, <leader>y copies to clipboard.
vim.keymap.set('n', '<leader>y', '\"+y')
vim.keymap.set('v', '<leader>y', '\"+y')
-- copies the whole line
vim.keymap.set('n', '<leader>Y', '\"+Y')

-- substitute globally the word I'm over
vim.keymap.set('n', '<leader>s', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')

-- AUGROUP + LSP REMAPS
local augroup = vim.api.nvim_create_augroup
local hktGroup = augroup('HKT', {})

local autocmd = vim.api.nvim_create_autocmd

autocmd({'BufWritePre'}, {
	group = hktGroup,
	pattern = '*',
	command = [[%s/\s\+$//e]],
})

autocmd('TextYankPost', {
	group = hktGroup,
	pattern = '*',
	callback = function ()
		vim.highlight.on_yank({
			higroup = 'IncSearch',
			timeout = 40,
		})
	end,
})

autocmd('LspAttach', {
	group = hktGroup,
	callback = function(ev)
		-- completion triggered by <c-x><c-o>
		 vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		 -- Buffer local mappings
		 -- see `:help vim.lsp.*` for documentation on the following
		 local opts = { buffer = ev.buf }
		 vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts)
		 vim.keymap.set('i', '<C-h>', function () vim.lsp.buf.signature_help() end, opts)

	end
})


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
