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

-- sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")


-- source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- AUGROUP + LSP REMAPS
local augroup = vim.api.nvim_create_augroup
local hktGroup = augroup('HKT', {})

local autocmd = vim.api.nvim_create_autocmd

-- remove trailing spaces on save
autocmd({ 'BufWritePre' }, {
    group = hktGroup,
    pattern = '*',
    command = [[%s/\s\+$//e]],
})

-- flash the yanked text on yank
autocmd('TextYankPost', {
    group = hktGroup,
    pattern = '*',
    callback = function()
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
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
    end
})


vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
