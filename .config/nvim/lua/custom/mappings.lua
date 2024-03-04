local M = {}

M.telescope = {
	n = {
		["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "Find keymaps" },
	},
}

M.gitsigns = {
	n = {
		["<leader>sh"] = {
			function()
				require("gitsigns").stage_hunk()
			end,
			"Stage hunk",
		},
		["<leader>uh"] = {
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			"Unstage hunk",
		},
	},
	v = {
		["<leader>sh"] = {
			function()
				require("gitsigns").stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end,
			"Stage hunk",
		},
		["<leader>uh"] = {
			function()
				require("gitsigns").undo_stage_hunk()
			end,
			"Unstage hunk",
		},
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Run Python Tests" },
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
			"Run Python Tests",
		},
	},
}

M.theme = {
	n = {
		["<leader>tt"] = {
			function()
				require("base46").toggle_theme()
			end,
			"Toggle Theme",
		},
	},
}

return M
