HOME = os.getenv "HOME"
local config = require "nvchad.configs.lspconfig"

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local on_attach = config.on_attach
local on_init = config.on_init
local capabilities = config.capabilities

local servers = {
  "nil_ls",
  "bashls",

  "lua_ls",

  "pyright",
  "ruff",

  --"svelete",
  "volar",
  "html",
  "cssls",
}
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = util.root_pattern "Cargo.toml",
  settings = {
    ["rust_analyzer"] = {},
  },
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = HOME .. "/.npm-packages/lib/node_modules/@vue/typescript-plugin/",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
  },
}
