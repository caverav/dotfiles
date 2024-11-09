local status, avante = pcall(require, "avante")

if not status then
	return
end

avante.setup({
	---@alias Provider "openai" | "claude" | "azure"  | "copilot" | [string]
	provider = "copilot",
	claude = {
		endpoint = "https://api.anthropic.com",
		model = "claude-3-5-sonnet-20240620",
		temperature = 0,
		max_tokens = 4096,
	},
	openai = {
		endpoint = "https://api.openai.com/v1",
		model = "gpt-3.5-turbo",
		temperature = 0,
		max_tokens = 4096,
	},
	mappings = {
		ask = "<leader>aa",
		edit = "<leader>ae",
		refresh = "<leader>ar",
		--- @class AvanteConflictMappings
		diff = {
			ours = "co",
			theirs = "ct",
			none = "c0",
			both = "cb",
			next = "]x",
			prev = "[x",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
	},
	hints = { enabled = true },
	windows = {
		wrap = true, -- similar to vim.o.wrap
		width = 30, -- default % based on available width
		sidebar_header = {
			align = "center", -- left, center, right for title
			rounded = true,
		},
	},
	highlights = {
		---@type AvanteConflictHighlights
		diff = {
			current = "DiffText",
			incoming = "DiffAdd",
		},
	},
	--- @class AvanteConflictUserConfig
	diff = {
		debug = false,
		autojump = true,
		---@type string | fun(): any
		list_opener = "copen",
	},
})
