local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { "cssls", "emmet_ls", "clangd", "tailwindcss", "ltex" }
local navicServers = { "tsserver", "sumneko_lua", "html", "jsonls", "yamlls" }

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
			require("lsp-inlayhints").on_attach(client, bufnr)
			-- require("lsp_signature").on_attach({
			-- 	bind = true, -- This is mandatory, otherwise border config won't get registered.
			-- 	handler_opts = {
			-- 		border = "rounded",
			-- 	},
			-- }, bufnr)
			require("aerial").on_attach(client, bufnr)
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

vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_mode = 0
vim.opt.conceallevel = 1
vim.g.tex_conceal = "abdmg"
lspconfig.ltex.setup({
	settings = {
		ltex = {
			language = "es",
		},
	},
})
