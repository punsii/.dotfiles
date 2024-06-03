-- This file  needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
require("autocmds")

local M = {}

M.mappings = require("mappings")
M.plugins = "plugins"
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
