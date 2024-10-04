local plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "vimdoc",

        -- real programming languages
        "bash",
        "c",
        "go",
        "lua",
        "nix",
        "python",
        "rust",

        -- webster shit
        "css",
        "html",
        "javascript",
        "svelte",
        "typescript",
        "vue",

        -- structured text
        "csv",
        "json",
        "xml",
        "yaml",
        "markdown",
      },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = "G",
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = "name",
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_filetypes = { "markdown" }
      vim.g.mkdp_open_to_the_world = 1
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = 8894
      vim.g.mkdp_browser = "none"
      vim.g.mkdp_echo_preview_url = 1
    end,
  },
  --{
  --	"rcarriga/nvim-dap-ui",
  --	dependencies = "mfussenegger/nvim-dap",
  --	config = function()
  --		local dap = require("dap")
  --		local dapui = require("dapui")
  --		dapui.setup()
  --		dap.listeners.after.event_initialized["dapui_config"] = function()
  --			dapui.open()
  --		end
  --		dap.listeners.before.event_terminated["dapui_config"] = function()
  --			dapui.close()
  --		end
  --		dap.listeners.before.event_exited["dapui_config"] = function()
  --			dapui.close()
  --		end
  --	end,
  --},
  --{
  --	"mfussenegger/nvim-dap",
  --	config = function(_, opts)
  --		require("core.utils").load_mappings("dap")
  --	end,
  --},
  --{
  --	"mfussenegger/nvim-dap-python",
  --	ft = "python",
  --	dependencies = {
  --		"mfussenegger/nvim-dap",
  --		"rcarriga/nvim-dap-ui",
  --	},
  --	config = function(_, opts)
  --		local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
  --		require("dap-python").setup(path)
  --		require("core.utils").load_mappings("dap_python")
  --	end,
  --},
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "black",
        "debugpy",
        "mypy",
        "nil",
        "pyright",
        "ruff-lsp",
        "rust-analyzer",
        "stylua",
        "isort",
        "prettierd",
      },
      -- "vtsls",
      -- "vue-language-server",
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "jmbuhr/otter.nvim",
    config = function()
      local otter = require "otter"
      -- table of embedded languages to look for.
      -- default = nil, which will activate
      -- any embedded languages found
      local languages = { "python", "lua", "bash", "nix" }

      -- enable completion/diagnostics
      -- defaults are true
      local completion = true
      local diagnostics = true
      -- treesitter query to look for embedded languages
      -- uses injections if nil or not set
      local tsquery = nil

      otter.activate(languages, completion, diagnostics, tsquery)
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  {
    "stevearc/conform.nvim",
    cond = false, -- does currently not work well with treefmt-nix
    ft = { "*" },
    -- Enables format on save
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },
  -- add this to your lua/plugins.lua, lua/plugins/init.lua,  or the file you keep your other plugins:
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    -- 😀
    "nvim-telescope/telescope-symbols.nvim",
  },
}

return plugins
