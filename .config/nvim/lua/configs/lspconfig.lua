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

local bin = vim.uv.fs_realpath(vim.fn.exepath "vue-language-server")
local root = vim.fs.dirname(vim.fs.dirname(bin))
local vue_plugin_location = root .. "/lib/language-tools/node_modules/.pnpm/node_modules/@vue/typescript-plugin"
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_plugin_location,
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
  tinymist = {}, --typst

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
