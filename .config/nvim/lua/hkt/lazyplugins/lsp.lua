return {
	'williamboman/mason-lspconfig.nvim',
	dependencies = {
		'williamboman/mason.nvim',
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lua',
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',
		'j-hui/fidget.nvim'
	},
	config = function()
		require('mason').setup()
		require('fidget').setup({})

		--local capabilities = require('cmp_nvim_lsp').default_capabilities()
		-- there's probably a cleaner way to do this
		local capabilities = vim.tbl_deep_extend(
			'force',
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require('cmp_nvim_lsp').default_capabilities()
		)


		require('mason-lspconfig').setup({
			ensure_installed = {
				'lua_ls',
				'rust_analyzer',
				'tsserver',
                --'tailwindcss'
			},
			handlers = {
				function(server_name) --default handler (is optional)
					require('lspconfig')[server_name].setup({
						capabilities = capabilities
					})
				end,
				['rust_analyzer'] = function ()
					local lspconfig = require('lspconfig')
					lspconfig.rust_analyzer.setup({
						on_attach = function(client, bufnr)
							vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
						end
					})
				end,
				--maybe
				['lua_ls'] = function ()
					local lspconfig = require('lspconfig')
					lspconfig.lua_ls.setup({
						settings = {
							Lua = {
								diagnostics = {
									globals = { 'vim' }
								}
							}
						}
					})
				end,
                ['tailwindcss'] = function ()
                    local lspconfig = require('lspconfig')
                    lspconfig.tailwindcss.setup({
                        cmd = { 'tailwindcss-language-server', '--stdio' },
                        filetypes = { 'html', 'css', 'scss', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
                        root_dir = lspconfig.util.root_pattern('tailwind.config.js', 'tailwind.config.cjs', 'package.json'),
                        settings = {},
                    })
                end,
			},
		})

		local cmp = require('cmp')
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
      				expand = function(args)
					-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
				end,
    			},
			window = {
				-- completion = cmp.config.window.bordered(),
				-- documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
				['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
				['<C-y>'] = cmp.mapping.confirm({ select = true }),
				['<C-space>'] = cmp.mapping.complete(),




				-- DEFULT ONES
				-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
				-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
				-- ['<C-Space>'] = cmp.mapping.complete(),
				-- ['<C-e>'] = cmp.mapping.abort(),
				-- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),

			-- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				-- { name = 'vsnip' }, -- For vsnip users.
				{ name = 'luasnip' }, -- For luasnip users.
				-- { name = 'ultisnips' }, -- For ultisnips users.
				-- { name = 'snippy' }, -- For snippy users.
			}, {
				{ name = 'nvim_lua' },
				{ name = 'path' },
				{ name = 'buffer', keyword_length = 5 },
			})
		})

		vim.diagnostic.config({
			virtual_text = true
		})
	end
}
