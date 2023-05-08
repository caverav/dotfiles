local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = {
	"bashls",
	"clangd",
	-- "cpplint",
	"cssls",
	"dockerls",
	"efm",
	"emmet_ls",
	-- "eslint",
	"gradle_ls",
	-- "hadolint",
	"jdtls",
	"kotlin_language_server",
	-- "ktlint",
	"lemminx",
	-- "ltex",
	"marksman",
	"phpactor",
	-- "prettierd",
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
local navicServers = { "tsserver", "lua_ls", "html", "jsonls", "yamlls" }

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
