require "nvchad.mappings"

local map = vim.keymap.set

map({ "n", "v" }, "qq", ":qa<CR>", { desc = "Quit" })

map({ "n" }, "<leader>fk", "<cmd> Telescope keymaps <CR>", { desc = "Find keymaps" })

map(
  { "n", "v" },
  "<leader>co",
  ":LspStop <CR> :IBLDisable <CR> :set signcolumn=no <CR> :set nonumber <CR> ",
  { desc = "Enable Copy mode" }
)
map(
  { "n", "v" },
  "<leader>cp",
  ":LspStart <CR> :IBLEnable <CR> :set signcolumn=yes <CR> :set number <CR> ",
  { desc = "Disable Copy mode" }
)
map({ "n", "v" }, "<leader>S", ":set spell!<CR>", { desc = "Toggle spell" })
map({ "n", "v" }, "<leader>sp", "1z=", { desc = "Accept first spell suggestion" })

map({ "n" }, "<leader>gd", function()
  if next(require("diffview.lib").views) == nil then
    vim.cmd "DiffviewOpen"
  else
    vim.cmd "DiffviewClose"
  end
end, { desc = "Goto Definition" })

-- not really a mapping but neccessary for lazygit integration
function EditLineFromLazygit(file_path, line)
  local path = vim.fn.expand "%:p"
  if path == file_path then
    vim.cmd(tostring(line))
  else
    vim.cmd("e " .. file_path)
    vim.cmd(tostring(line))
  end
end

function EditFromLazygit(file_path)
  local path = vim.fn.expand "%:p"
  if path == file_path then
    return
  else
    vim.cmd("e " .. file_path)
  end
end

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

map({ "n" }, "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Git reset hunk" })
map({ "v" }, "<leader>gr", function()
  require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
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
map({ "n", "v" }, "<leader>fm", ":silent exec '!treefmt %'<CR>", { desc = "format with treefmt" })
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

map({ "n" }, "<leader>sy", function()
  require("telescope.builtin").symbols {}
end)
map({ "i" }, "<C-e>", function()
  -- ♋ 👌
  require("telescope.builtin").symbols {}
end)

-- treesitter-textobjects
local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
map({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
map({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
map({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
map({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
map({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
map({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

--  make gitsigns.nvim movement repeatable with ; and , keys.
local gs = require "gitsigns"
-- make sure forward function comes first
local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
-- Or, use `make_repeatable_move` or `set_last_move` functions for more control. See the code for instructions.

map({ "n", "x", "o" }, "]h", next_hunk_repeat)
map({ "n", "x", "o" }, "[h", prev_hunk_repeat)

-- Examples --

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
