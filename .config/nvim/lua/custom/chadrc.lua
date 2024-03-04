---@type ChadrcConfig
require("custom.autocmds")

local M = {}

M.mappings = require("custom.mappings")
M.plugins = "custom.plugins"
M.ui = {
	theme = "everforest",
	tabufline = {
		lazyload = false,
	},
	theme_toggle = { "everforest", "everforest_light" },
	nvdash = {
		load_on_startup = true,
	},
}
return M
