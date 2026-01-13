{
  description = "NvChad-like Nixvim Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Added treefmt input
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixvim,
      treefmt-nix,
    }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      # --- Packages (The Editor) ---
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};

          nixvimModule = {
            # Base Settings
            viAlias = true;
            vimAlias = true;

            env = {
              COLORTERM = "truecolor";
            };

            globals = {
              mapleader = " ";
              maplocalleader = " ";
            };

            opts = {
              # --- Search Settings (Requested) ---
              ignorecase = true; # Ignore case in search patterns
              smartcase = true; # Override ignorecase if search contains capitals

              # --- NvChad Defaults ---
              laststatus = 3; # Global statusline
              showmode = false; # Don't show mode in cmd line (statusline handles it)
              splitkeep = "screen"; # Keep text on screen during splits

              # Indenting & Tabs
              expandtab = true;
              shiftwidth = 2;
              smartindent = true;
              tabstop = 2;
              softtabstop = 2; # Added from defaults

              # UI
              fillchars = {
                eob = " ";
              }; # Hide ~ on empty lines
              mouse = "a";
              number = true;
              numberwidth = 2;
              ruler = false;
              signcolumn = "yes";
              splitbelow = true;
              splitright = true;
              termguicolors = true;
              cursorline = true;

              # Timing & Undo
              timeoutlen = 400;
              updatetime = 250; # Faster completion/swap write
              undofile = true;

              # --- User Overrides ---
              cursorlineopt = "both"; # Highlights line number and cursor line
              scrolloff = 5; # Keep 5 lines context when scrolling
              spelllang = "en_us,de_de"; # Dual language spellcheck
              clipboard = "unnamedplus";

              # Misc flags (using Lua string format for appending)
              shortmess = "sI"; # Disable nvim intro
              whichwrap = "<>[]hl"; # Wrap movement to next line
              diffopt = "internal,filler,closeoff,vertical"; # Force vertical diffs

              # Theme (Reference)
              background = "light";
            };

            # Theme
            colorschemes.everforest = {
              enable = true;
              settings.background = "medium";
            };

            # --- Plugins ---
            plugins = {
              web-devicons.enable = true;

              lualine = {
                enable = true;
                settings.options = {
                  theme = "everforest";
                  globalstatus = true;
                };
              };

              bufferline = {
                enable = true;
                settings.options = {
                  offsets = [
                    {
                      filetype = "NvimTree";
                      text = "File Explorer";
                      highlight = "Directory";
                      separator = true;
                    }
                  ];
                  buffer_close_icon = "x";
                  close_command = "bdelete %d";

                  always_show_bufferline = false;
                };
              };

              indent-blankline = {
                enable = true;
                settings = {
                  indent = {
                    char = "│";
                    tab_char = "│";
                  };
                  scope = {
                    enabled = false;
                  }; # NvChad often disables scope or uses defaults
                  exclude = {
                    filetypes = [
                      "help"
                      "alpha"
                      "dashboard"
                      "neo-tree"
                      "Trouble"
                      "trouble"
                      "lazy"
                      "mason"
                      "notify"
                      "toggleterm"
                      "lazyterm"
                    ];
                  };
                };
              };

              nvim-tree = {
                enable = true;
                settings = {
                  disable_netrw = true;
                  git = {
                    enable = true;
                  };
                  view = {
                    width = 30;
                  };
                };
              };

              telescope = {
                enable = true;
                extensions = {
                  fzf-native.enable = true;
                };
              };

              treesitter = {
                enable = true;
                settings = {
                  indent.enable = true;
                  highlight.enable = true;
                };
              };

              # Treesitter Textobjects (Fixed snake_case settings)
              treesitter-textobjects = {
                enable = true;
                settings = {
                  select = {
                    enable = true;
                    lookahead = true;
                    keymaps = {
                      "af" = "@function.outer";
                      "if" = "@function.inner";
                      "ac" = "@class.outer";
                      "ic" = "@class.inner";
                    };
                  };
                  move = {
                    enable = true;
                    set_jumps = true;
                    goto_next_start = {
                      "]m" = "@function.outer";
                      "]]" = "@class.outer";
                    };
                    goto_previous_start = {
                      "[m" = "@function.outer";
                      "[[" = "@class.outer";
                    };
                  };
                };
              };

              lsp = {
                enable = true;
                servers = {
                  nixd.enable = true;
                  lua_ls.enable = true;
                  bashls.enable = true;
                  pyright.enable = true;
                };
              };

              cmp = {
                enable = true;
                autoEnableSources = true;
                settings = {
                  mapping = {
                    "<C-k>" = "cmp.mapping.select_prev_item()";
                    "<C-j>" = "cmp.mapping.select_next_item()";
                    "<C-d>" = "cmp.mapping.scroll_docs(-4)";
                    "<C-f>" = "cmp.mapping.scroll_docs(4)";
                    "<C-Space>" = "cmp.mapping.complete()";
                    "<CR>" = "cmp.mapping.confirm({ select = true })";
                    "<Tab>" =
                      "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, {'i', 's'})";
                    "<S-Tab>" =
                      "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, {'i', 's'})";
                  };
                  sources = [
                    { name = "nvim_lsp"; }
                    { name = "luasnip"; }
                    { name = "path"; }
                    { name = "buffer"; }
                  ];
                };
              };
              cmp-nvim-lsp.enable = true;
              cmp-buffer.enable = true;
              cmp-path.enable = true;
              cmp_luasnip.enable = true;

              luasnip.enable = true;
              friendly-snippets.enable = true;

              gitsigns.enable = true;
              nvim-autopairs.enable = true;
              comment.enable = true;

              conform-nvim = {
                enable = true;
                settings = {
                  format_on_save = {
                    lsp_fallback = true;
                    timeout_ms = 500;
                  };
                  formatters_by_ft = {
                    lua = [ "stylua" ];
                    python = [
                      "isort"
                      "black"
                    ];
                    nix = [ "nixfmt" ];
                  };
                };
              };

              which-key.enable = true;
              diffview.enable = true;

              otter.enable = true;
              quarto = {
                enable = true;
                settings = {
                  lspFeatures = {
                    languages = [
                      "r"
                      "python"
                      "julia"
                      "bash"
                    ];
                  };
                };
              };
            };

            extraPlugins = with pkgs.vimPlugins; [
              lazygit-nvim
              nvim-surround
              text-case-nvim
              telescope-symbols-nvim
            ];

            autoCmd = [
              {
                event = "BufWritePre";
                pattern = "*";
                command = "%s/\\s\\+$//e"; # Remove trailing whitespace
              }
              {
                event = "BufWritePost";
                pattern = "*";
                command = "silent! execute '!treefmt %'"; # Run treefmt on save (silent! prevents errors if treefmt isn't found)
              }
            ];

            # --- KEYMAPS ---
            keymaps = [
              # ========================
              # NvChad Base Mappings
              # ========================
              {
                mode = "i";
                key = "<C-b>";
                action = "<ESC>^i";
                options.desc = "Move beginning of line";
              }
              {
                mode = "i";
                key = "<C-e>";
                action = "<End>";
                options.desc = "Move end of line";
              }
              {
                mode = "i";
                key = "<C-h>";
                action = "<Left>";
                options.desc = "Move left";
              }
              {
                mode = "i";
                key = "<C-l>";
                action = "<Right>";
                options.desc = "Move right";
              }
              {
                mode = "i";
                key = "<C-j>";
                action = "<Down>";
                options.desc = "Move down";
              }
              {
                mode = "i";
                key = "<C-k>";
                action = "<Up>";
                options.desc = "Move up";
              }

              {
                mode = "n";
                key = "<C-h>";
                action = "<C-w>h";
                options.desc = "Switch window left";
              }
              {
                mode = "n";
                key = "<C-l>";
                action = "<C-w>l";
                options.desc = "Switch window right";
              }
              {
                mode = "n";
                key = "<C-j>";
                action = "<C-w>j";
                options.desc = "Switch window down";
              }
              {
                mode = "n";
                key = "<C-k>";
                action = "<C-w>k";
                options.desc = "Switch window up";
              }

              {
                mode = "n";
                key = "<Esc>";
                action = "<cmd>noh<CR>";
                options.desc = "Clear highlights";
              }
              {
                mode = "n";
                key = "<C-s>";
                action = "<cmd>w<CR>";
                options.desc = "Save file";
              }
              {
                mode = "n";
                key = "<C-c>";
                action = "<cmd>%y+<CR>";
                options.desc = "Copy whole file";
              }
              {
                mode = "n";
                key = "<leader>n";
                action = "<cmd>set nu!<CR>";
                options.desc = "Toggle line number";
              }
              {
                mode = "n";
                key = "<leader>rn";
                action = "<cmd>set rnu!<CR>";
                options.desc = "Toggle relative number";
              }

              {
                mode = "n";
                key = "<leader>ds";
                action = "<cmd>lua vim.diagnostic.setloclist()<CR>";
                options.desc = "LSP diagnostic loclist";
              }

              {
                mode = "n";
                key = "<leader>b";
                action = "<cmd>enew<CR>";
                options.desc = "New buffer";
              }
              {
                mode = "n";
                key = "<TAB>";
                action = "<cmd>BufferLineCycleNext<CR>";
                options.desc = "Next buffer";
              }
              {
                mode = "n";
                key = "<S-TAB>";
                action = "<cmd>BufferLineCyclePrev<CR>";
                options.desc = "Prev buffer";
              }
              {
                mode = "n";
                key = "<leader>x";
                action = "<cmd>bdelete<CR>";
                options.desc = "Close buffer";
              }

              {
                mode = "n";
                key = "<leader>/";
                action = "gcc";
                options = {
                  desc = "Toggle Comment";
                  remap = true;
                };
              }
              {
                mode = "v";
                key = "<leader>/";
                action = "gc";
                options = {
                  desc = "Toggle Comment";
                  remap = true;
                };
              }

              {
                mode = "n";
                key = "<C-n>";
                action = "<cmd>NvimTreeToggle<CR>";
                options.desc = "Toggle Explorer";
              }
              {
                mode = "n";
                key = "<leader>e";
                action = "<cmd>NvimTreeFocus<CR>";
                options.desc = "Focus Explorer";
              }

              {
                mode = "n";
                key = "<leader>fw";
                action = "<cmd>Telescope live_grep<CR>";
                options.desc = "Live grep";
              }
              {
                mode = "n";
                key = "<leader>fb";
                action = "<cmd>Telescope buffers<CR>";
                options.desc = "Find buffers";
              }
              {
                mode = "n";
                key = "<leader>fh";
                action = "<cmd>Telescope help_tags<CR>";
                options.desc = "Help tags";
              }
              {
                mode = "n";
                key = "<leader>ma";
                action = "<cmd>Telescope marks<CR>";
                options.desc = "Find marks";
              }
              {
                mode = "n";
                key = "<leader>fo";
                action = "<cmd>Telescope oldfiles<CR>";
                options.desc = "Find oldfiles";
              }
              {
                mode = "n";
                key = "<leader>fz";
                action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
                options.desc = "Fuzzy find in buffer";
              }
              {
                mode = "n";
                key = "<leader>cm";
                action = "<cmd>Telescope git_commits<CR>";
                options.desc = "Git commits";
              }
              {
                mode = "n";
                key = "<leader>gt";
                action = "<cmd>Telescope git_status<CR>";
                options.desc = "Git status";
              }
              {
                mode = "n";
                key = "<leader>ff";
                action = "<cmd>Telescope find_files<CR>";
                options.desc = "Find files";
              }
              {
                mode = "n";
                key = "<leader>fa";
                action = "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>";
                options.desc = "Find all files";
              }

              {
                mode = "n";
                key = "<leader>h";
                action = "<cmd>split<CR>";
                options.desc = "New horizontal split";
              }
              {
                mode = "n";
                key = "<leader>v";
                action = "<cmd>vsplit<CR>";
                options.desc = "New vertical split";
              }

              {
                mode = "n";
                key = "<leader>wK";
                action = "<cmd>WhichKey<CR>";
                options.desc = "WhichKey all keymaps";
              }

              # ========================
              # User Custom Mappings
              # ========================
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "qq";
                action = ":qa<CR>";
                options.desc = "Quit";
              }
              {
                mode = "n";
                key = ";";
                action = ":";
                options.desc = "Enter command mode";
              }
              {
                mode = "i";
                key = "jk";
                action = "<ESC>";
                options.desc = "Exit insert mode";
              }
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>d";
                action = "\"_d";
                options.desc = "Delete without yanking";
              }
              {
                mode = "n";
                key = "<leader>fk";
                action = "<cmd>Telescope keymaps<CR>";
                options.desc = "Find keymaps";
              }

              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>co";
                action = "<cmd>LspStop<CR><cmd>IBLDisable<CR><cmd>set signcolumn=no<CR><cmd>set nonumber<CR>";
                options.desc = "Enable Copy Mode";
              }
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>cp";
                action = "<cmd>LspStart<CR><cmd>IBLEnable<CR><cmd>set signcolumn=yes<CR><cmd>set number<CR>";
                options.desc = "Disable Copy Mode";
              }

              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>S";
                action = "<cmd>set spell!<CR>";
                options.desc = "Toggle spell";
              }
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>sp";
                action = "1z=";
                options.desc = "Accept spell suggestion";
              }

              {
                mode = "n";
                key = "<leader>gd";
                action = "<cmd>lua ToggleDiffview()<CR>";
                options.desc = "Toggle Git Diff";
              }
              {
                mode = "n";
                key = "<leader>q";
                action = "<cmd>lua ToggleQuickfix()<CR>";
                options.desc = "Toggle Quickfix";
              }

              {
                mode = [
                  "o"
                  "x"
                ];
                key = "ah";
                action = ":<C-U>Gitsigns select_hunk<CR>";
              }
              {
                mode = [
                  "o"
                  "x"
                ];
                key = "ih";
                action = ":<C-U>Gitsigns select_hunk<CR>";
              }
              {
                mode = "n";
                key = "<leader>gs";
                action = "<cmd>lua require('gitsigns').stage_hunk()<CR>";
                options.desc = "Stage hunk";
              }
              {
                mode = "v";
                key = "<leader>gs";
                action = "<cmd>lua require('gitsigns').stage_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>";
                options.desc = "Stage hunk";
              }
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>gu";
                action = "<cmd>lua require('gitsigns').undo_stage_hunk()<CR>";
                options.desc = "Undo stage hunk";
              }
              {
                mode = "n";
                key = "<leader>gr";
                action = "<cmd>lua require('gitsigns').reset_hunk()<CR>";
                options.desc = "Reset hunk";
              }
              {
                mode = "v";
                key = "<leader>gr";
                action = "<cmd>lua require('gitsigns').reset_hunk({vim.fn.line('.'), vim.fn.line('v')})<CR>";
                options.desc = "Reset hunk";
              }
              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>gp";
                action = "<cmd>lua require('gitsigns').preview_hunk()<CR>";
                options.desc = "Preview hunk";
              }

              {
                mode = "n";
                key = "]c";
                action = "<cmd>lua GitNavNext()<CR>";
              }
              {
                mode = "n";
                key = "[c";
                action = "<cmd>lua GitNavPrev()<CR>";
              }

              {
                mode = [
                  "n"
                  "v"
                ];
                key = "<leader>fm";
                action = ":silent exec '!treefmt %'<CR>";
                options.desc = "Format with treefmt";
              }

              {
                mode = "n";
                key = "<leader>sy";
                action = "<cmd>lua require('telescope.builtin').symbols()<CR>";
              }
              {
                mode = "i";
                key = "<C-e>";
                action = "<cmd>lua require('telescope.builtin').symbols()<CR>";
              }

              {
                mode = "n";
                key = "Q";
                action = "<cmd>lua RepeatSearch()<CR>";
              }

              {
                mode = "n";
                key = "<leader>lg";
                action = "<cmd>LazyGit<CR>";
                options.desc = "LazyGit";
              }
              # Toggle Theme
              {
                mode = "n";
                key = "<leader>tt";
                action = "<cmd>lua ToggleTheme()<CR>";
                options.desc = "Toggle Theme";
              }
            ];

            # --- Extra Lua Config ---
            extraConfigLua = ''
              require("nvim-surround").setup({})

              -- Filetype detection (From your options.lua)
              vim.filetype.add {
                filename = {
                  [".gitlab-ci.yml"] = "yaml.gitlab",
                },
                pattern = {
                  [".*%.sage"] = "python"
                },
              }

              function ToggleTheme()
                if vim.o.background == "dark" then
                  vim.o.background = "light"
                else
                  vim.o.background = "dark"
                end
              end

              function ToggleDiffview()
                local views = require("diffview.lib").views
                if next(views) == nil then
                  vim.cmd("DiffviewOpen")
                else
                  vim.cmd("DiffviewClose")
                end
              end

              function ToggleQuickfix()
                local qf_winid = vim.fn.getqflist({ winid = 0 }).winid
                local action = qf_winid > 0 and "cclose" or "copen"
                vim.cmd("botright " .. action)
              end

              function RepeatSearch()
                local count = vim.fn.searchcount().total
                while count > 0 do
                  vim.cmd "normal n."
                  count = count - 1
                end
              end

              function GitNavNext()
                if vim.wo.diff then
                  vim.cmd.normal { "]c", bang = true }
                else
                  require("gitsigns").nav_hunk("next")
                end
              end

              function GitNavPrev()
                if vim.wo.diff then
                  vim.cmd.normal { "[c", bang = true }
                else
                  require("gitsigns").nav_hunk("prev")
                end
              end

              -- Safe loading for Treesitter Textobjects Repeatable Move
              vim.schedule(function()
                local status, ts_repeat_move = pcall(require, "nvim-treesitter.textobjects.repeatable_move")
                if status then
                  vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
                  vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
                  vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
                  vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
                  vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
                vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

                  local gs_status, gs = pcall(require, "gitsigns")
                  if gs_status then
                    local next_hunk_repeat, prev_hunk_repeat = ts_repeat_move.make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
                    vim.keymap.set({ "n", "x", "o" }, "]h", next_hunk_repeat)
                    vim.keymap.set({ "n", "x", "o" }, "[h", prev_hunk_repeat)
                  end
                end
              end)

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
            '';
          };

          nvim = nixvim.legacyPackages.${system}.makeNixvim nixvimModule;
        in
        {
          default = nvim;
        }
      );

      # --- Formatter Configuration ---
      formatter = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          treefmtEval = treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";
            programs.stylua.enable = true;
            programs.nixfmt.enable = true;
            programs.prettier = {
              enable = true;
              excludes = [
                "data/*"
                "flake.lock"
                "lazy-lock.json"
              ];
            };
          };
        in
        treefmtEval.config.build.wrapper
      );

      # --- DevShell Configuration ---
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          # Re-evaluate treefmt to get the wrapper inside the shell
          treefmtEval = treefmt-nix.lib.evalModule pkgs {
            projectRootFile = "flake.nix";
            programs.stylua.enable = true;
            programs.nixfmt.enable = true;
            programs.prettier = {
              enable = true;
              excludes = [
                "data/*"
                "flake.lock"
                "lazy-lock.json"
              ];
            };
          };
        in
        {
          default = pkgs.mkShell {
            buildInputs = [
              treefmtEval.config.build.wrapper
              pkgs.lua-language-server
            ];
          };
        }
      );
    };
}
