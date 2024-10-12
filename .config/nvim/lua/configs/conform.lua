local options = {
  formatters_by_ft = {
    -- Use the "*" filetype to run formatters on all filetypes.
    ["*"] = { "treefmt" },
  },
  formatters = {
    treefmt = {
      inherit = false, -- default if the formatter does not exist yet
      command = "treefmt",
      args = { "--stdin", "$FILENAME" },
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 2000,
    lsp_fallback = false,
  },
}
return options

-- XXX formatters that worked well previously
-- null_ls.builtins.code_actions.statix,
-- null_ls.builtins.diagnostics.mypy,
-- null_ls.builtins.diagnostics.deadnix,
-- null_ls.builtins.diagnostics.pylint,
-- null_ls.builtins.diagnostics.statix,
-- null_ls.builtins.formatting.black,
-- null_ls.builtins.formatting.isort,
-- null_ls.builtins.formatting.prettierd,
-- null_ls.builtins.formatting.nixpkgs_fmt,
-- null_ls.builtins.formatting.stylua,
