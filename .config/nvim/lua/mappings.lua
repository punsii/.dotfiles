require "nvchad.mappings"

local map = vim.keymap.set

map({ "n" }, "<leader>fk", "<cmd> Telescope keymaps <CR>", { desc = "Find keymaps" })

map({ "n" }, "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd "DiffviewOpen"
  else
    vim.cmd "DiffviewClose"
  end
end, { desc = "Goto Definition" })

-- working with hunks
map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
map({ "n" }, "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Git stage hunk" })
map({ "v" }, "<leader>gs", function()
  require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
end, { desc = "Git stage hunk" })
map({ "n", "v" }, "<leader>gu", function()
  require("gitsigns").undo_stage_hunk()
end, { desc = "Git unstage hunk" })
map({ "n", "v" }, "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Git reset hunk" })
map({ "n", "v" }, "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Git preview hunk" })
--XXX how is the plugin setting used after 2.5?
--M.dap = {
--	plugin = true,
--	n = {
--		["<leader>db"] = { "<cmd> DapToggleBreakpoint <CR>", "Run Python Tests" },
--	},
--}
--
--XXX how is the plugin setting used after 2.5?
--M.dap_python = {
--	plugin = true,
--	n = {
--		["<leader>dpr"] = {
--			function()
--				require("dap-python").test_method()
--			end,
--			"Run Python Tests",
--		},
--	},
--}
-- XXX Overwrites the default mapping
-- M.general = {
-- 	n = {
-- 		["<leader>fm"] = {
-- 			function()
-- 				vim.lsp.buf.format({
-- 					async = true,
-- 					filter = function(client)
-- 						return client.name == "null-ls"
-- 					end,
-- 				})
-- 			end,
-- 			"LSP formatting",
-- 		},
-- 	},
map({ "n" }, "<leader>tt", function()
  require("base46").toggle_theme()
end, { desc = "Toggle Theme" })

map("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal { "]c", bang = true }
  else
    require("gitsigns").nav_hunk "next"
  end
end)

map("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal { "[c", bang = true }
  else
    require("gitsigns").nav_hunk "prev"
  end
end)

--map("i", "<C-k>", "<Up>", { desc = "Move up" })
--
---- multiple modes
--map({ "i", "n" }, "<C-k>", "<Up>", { desc = "Move down" })
--
--map("n", "<leader>ff", ":Telescope <cr>")
--
---- mapping with a lua function
--map("n", "<A-i>", function()
--  require("nvchad.term").toggle({ pos = "sp", id ='abc' })
--end, { desc = "Terminal toggle floating" })
--
--
---- Disable mappings
--local nomap = vim.keymap.del
--
--nomap("i", "<C-k>")
--nomap("n", "<C-k>")
