require "nvchad.options"

vim.filetype.add {
  filename = {
    [".gitlab-ci.yml"] = "yaml.gitlab",
  },
}

local o = vim.o
o.cursorlineopt = "both"
o.scrolloff = 5
o.spelllang = "en_us,de_de"
o.diffopt = o.diffopt .. ",vertical"
