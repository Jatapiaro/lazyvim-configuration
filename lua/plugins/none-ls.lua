return {
	"nvimtools/none-ls.nvim",
	opts = function(_, opts)
		local nls = require("null-ls")
		opts.root_dir = opts.root_dir or 
			require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
		opts.sources = vim.list_extend(opts.sources or {}, {
			nls.builtins.formatting.black,
			nls.builtins.diagnostics.mypy,
			nls.builtins.diagnostics.ruff,
		})
	end,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			vim.api.nvim_clear.autocmds({
				group = augroup,
				buffer = bufnr,
			})
		end
	end, 
}