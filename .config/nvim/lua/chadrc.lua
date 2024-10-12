-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

require "autocmds"

---@type ChadrcConfig
local M = {}

M.base46 = {
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
