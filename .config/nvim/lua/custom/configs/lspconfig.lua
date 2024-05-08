local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})
lspconfig.ruff_lsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "python" },
})

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	root_dir = util.root_pattern("Cargo.toml"),
	settings = {
		["rust_analyzer"] = {},
	},
})
-- lspconfig.volar.setup({}) XXX fix formatting issues
-- lspconfig.vtsls.setup({})
lspconfig.svelte.setup({})
lspconfig.nil_ls.setup({})
lspconfig.lua_ls.setup({ capabilities = "" })
