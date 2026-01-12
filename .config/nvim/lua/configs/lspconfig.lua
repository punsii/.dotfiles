--old setup code:
-- local config = require "nvchad.configs.lspconfig"
-- local on_attach = config.on_attach
-- local on_init = config.on_init
-- local capabilities = config.capabilities
-- -- lsps with default config
-- for _, lsp in ipairs(servers) do
--   vim.lsp.config(lsp, {
--     on_attach = on_attach,
--     on_init = on_init,
--     capabilities = capabilities,
--   })
--   vim.lsp.enable(lsp)
-- end

-- HOME = os.getenv "HOME"

require("nvchad.configs.lspconfig").defaults()

local vue_language_server_path =
  "/nix/store/c3w8npbg5av7k9mfxgazwgzg69pqwqv2-vue-language-server-3.1.5/./lib/language-tools/node_modules/.pnpm/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

local servers = {
  nil_ls = {},
  bashls = {},

  gitlab_ci_ls = {},

  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },

  pyright = {},
  ruff = {},

  java_language_server = {},

  -- the javascript ecosystem sucks"
  cssls = {},
  -- "eslint" = {},
  vue_ls = {},
  vtsls = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  },
  html = {},
  tailwindcss = {},
  mdx_analyzer = {},

  marksman = {},

  rust_analyzer = {
    -- on_init = on_init, -- Do not set on_init! (Will be set by 'settings')
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    settings = {
      ["rust_analyzer"] = {},
    },
  },
}

for name, opts in pairs(servers) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- vim.lsp.config('ts_ls, {
--   on_attach = on_attach,
--   on_init = on_init,
--   capabilities = capabilities,
--   init_options = {
--     plugins = {
--       {
--         name = "@vue/typescript-plugin",
--         location = HOME .. "/.npm-packages/lib/node_modules/@vue/typescript-plugin/",
--         languages = { "javascript", "typescript" },
--       },
--     },
--   },
--   filetypes = {
--     "javascript",
--     "typescript",
--     "vue",
--   },
-- })
