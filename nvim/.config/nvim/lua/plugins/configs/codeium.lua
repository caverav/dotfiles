local status_ok, codeium = pcall(require, "codeium")
if not status_ok then
	return
end

codeium.setup({
	enable_chat = true,
	enable_local_search = false,
	enable_index_service = false,
	search_max_workspace_file_count = 5000,
})
