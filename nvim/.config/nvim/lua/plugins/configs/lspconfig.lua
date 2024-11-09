local present, lspconfig = pcall(require, "lspconfig")

if not present then
	return
end

-- require("base46").load_highlight("lsp")
require("nvchad.lsp")


on_attach = function(client, bufnr)
	if vim.g.vim_version > 7 then
		-- nightly
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		-- stable
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end


	-- if client.server_capabilities.signatureHelpProvider then
	-- 	require("nvchad.signature").setup(client)
	-- end
end

capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

-- lspconfig.sumneko_lua.setup {
--   on_attach = M.on_attach,
--   capabilities = M.capabilities,
--
--   settings = {
--     Lua = {
--       diagnostics = {
--         globals = { "vim" },
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand "$VIMRUNTIME/lua"] = true,
--           [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
--         },
--         maxPreload = 100000,
--         preloadFileSize = 10000,
--       },
--     },
--   },
-- }

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				},
				maxPreload = 100000,
				preloadFileSize = 10000,
			},
		},
	},
})

-- eslint
lspconfig.eslint.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

local servers = {
	"bashls",
	"clangd",
	"gopls",
	-- "cpplint",
	"cssls",
	"dockerls",
	"efm",
	"emmet_ls",
	"eslint-lsp",
	"gradle_ls",
	-- "hadolint",
	"jdtls",
	"kotlin_language_server",
	-- "ktlint",
	"lemminx",
	-- "ltex",
	"marksman",
	"phpactor",
	"prettierd",
	"prosemd_lsp",
	"psalm",
	-- "pylint",
	"pyright",
	-- "quick_lint_js",
	"rome",
	-- "semgrep",
	-- "shellharden",
	-- "shfmt",
	"solargraph",
	"sourcery",
	-- "spellcheck",
	-- "stylua",
	"tailwindcss",
	"vimls",
	-- "vint",
	-- "vstls",
}
local navicServers = { "ts_ls", "lua_ls", "html", "jsonls", "yamlls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

for _, lsp in ipairs(navicServers) do
	lspconfig[lsp].setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			require("nvim-navic").attach(client, bufnr)
			-- require("lsp-inlayhints").on_attach(client, bufnr)
			-- require("lsp_signature").on_attach({
			-- 	bind = true, -- This is mandatory, otherwise border config won't get registered.
			-- 	handler_opts = {
			-- 		border = "rounded",
			-- 	},
			-- }, bufnr)
			-- require("aerial").on_attach(client, bufnr)
		end,
		capabilities = capabilities,
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})
end
require('ufo').setup()
-- local configs = require("lspconfig.configs")
-- if not configs.snyk then
-- 	configs.snyk = {
-- 		default_config = {
-- 			cmd = { "/usr/local/bin/snyk-ls", "-f", "/path/to/log/snyk-ls-vim.log" },
-- 			root_dir = function(name)
-- 				return lspconfig.util.find_git_ancestor(name) or vim.loop.os_homedir()
-- 			end,
-- 			init_options = {
-- 				activateSnykCode = "true",
-- 			},
-- 		},
-- 	}
-- end
-- lspconfig.snyk.setup({
-- 	on_attach = on_attach,
-- })

vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = "abdmg"
