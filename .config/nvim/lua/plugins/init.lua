local plugins = {
  -- Git
  {
    "tpope/vim-fugitive",
    cmd = "G",
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  -- Navigation
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
      filters = {
        dotfiles = false,
        custom = { "^.git$" },
      },
    },
  },
  {
    "davidmh/mdx.nvim",
    config = true,
    event = "BufEnter *.mdx",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
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

  -- LSP configuration
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "nil",

        "bash-language-server",
        "lua-language-server",
        "stylua",

        "black",
        "debugpy",
        "isort",
        "mypy",
        "pyright",
        "ruff",
        "ruff-lsp",

        "rust-analyzer",

        "css-lsp",
        "eslint_d",
        "prettierd",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
      -- "vtsls",
      -- "vue-language-server",
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
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("quarto").setup {}
    end,
    ft = { "quarto" },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
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
    "stevearc/conform.nvim",
    ft = { "*" },
    -- Enables format on save
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    config = function()
      require "configs.treesitter-textobjects"
    end,
  },
  {
    "mawkler/demicolon.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {},
  },
  {
    "numToStr/Comment.nvim", -- Toggle line comments
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  {
    "kylechui/nvim-surround", -- Actions with braces, quotation marks, etc..
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "nvim-telescope/telescope-symbols.nvim", -- 😀
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      local telescope = require "telescope"
      local telescopeConfig = require "telescope.config"

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- Search hidden files
      table.insert(vimgrep_arguments, "--hidden")
      -- Don't search in the '.git' or 'node_modules' directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/node_modules/*")

      telescope.setup {
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
      }
      return conf
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {
        prefix = "<leader>rc",
      }
      require("telescope").load_extension "textcase"
    end,
    keys = {
      "<leader>rc", -- Default invocation prefix
      { "<leader>rc.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
}

return plugins
