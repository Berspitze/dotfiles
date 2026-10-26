return {
	"scalameta/nvim-metals",
	ft = { "scala", "sbt" },
	dependencies = { "nvim-lua/plenary.nvim", "saghen/blink.cmp" },
	config = function(self)
		vim.opt_global.shortmess:remove("F")

		local metals = require("metals")
		local cfg = metals.bare_config()
		cfg.capabilities = require("blink.cmp").get_lsp_capabilities()
		cfg.init_options.statusBarProvider = "off"
		cfg.settings = { showImplicitArguments = true }
		cfg.on_attach = function(_, bufnr)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
		end

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
			pattern = self.ft,
			callback = function() metals.initialize_or_attach(cfg) end,
		})
	end,
}
