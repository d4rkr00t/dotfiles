local setup, trouble = pcall(require, "trouble")

if not setup then
	return
end

trouble.setup({
	use_diagnostic_signs = false,
})
