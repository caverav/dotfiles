local present, trouble = pcall(require, "dapui")

if not present then
	return
end

trouble.setup({})
