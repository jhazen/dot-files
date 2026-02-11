local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      {
        "<leader>db",
        function() require("dap").toggle_breakpoint() end,
        desc = "Toggle Breakpoint"
      },

      {
        "<leader>dc",
        function() require("dap").continue() end,
        desc = "Continue"
      },

      {
        "<leader>dC",
        function() require("dap").run_to_cursor() end,
        desc = "Run to Cursor"
      },

      {
        "<leader>dT",
        function() require("dap").terminate() end,
        desc = "Terminate"
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    ---@type MasonNvimDapSettings
    opts = {
      handlers = {},
      automatic_installation = {
        exclude = {
          "delve",
          "python",
        },
      },
      ensure_installed = {
        "bash",
        "codelldb",
        "php",
        "python",
      },
    },
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle({})
        end,
        desc = "Dap UI"
      },
    },
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      local python = vim.fn.expand("/usr/bin/python")
      require("dap-python").setup(python)
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
  { url = "https://github.com/tpope/vim-fugitive" },
  {
    'nyngwang/suave.lua',
    config = function ()
      require('suave').setup {
        auto_save = {
          enabled = true,
        },
        store_hooks = {
          before_mksession = {
            function ()
              for _, w in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), 'ft') == 'neo-tree' then
                  vim.api.nvim_win_close(w, false)
                end
              end
            end,
          },
          after_mksession = {
            function (data)
              data.colorscheme = vim.g.colors_name
            end,
          },
        },
        restore_hooks = {
          after_source = {
            function (data)
              if not data then return end
              vim.cmd(string.format([[
                color %s
                doau ColorScheme %s
              ]], data.colorscheme, data.colorscheme))
            end,
            function (data)
              if not data then return end
              local current_tab = vim.api.nvim_get_current_tabpage() -- Store current tab to return to it later
              for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
                vim.api.nvim_set_current_tabpage(tab_id) -- Switch to the tab
                  vim.cmd('filetype detect')
              end
              vim.api.nvim_set_current_tabpage(current_tab) -- Return to the original tab
            end,
            function (data)
              if not data then return end
              local current_tab = vim.api.nvim_get_current_tabpage() -- Store current tab to return to it later
              vim.cmd('tabfirst')
              vim.cmd('lua require(\"kiwi\").open_wiki_index()')
              vim.api.nvim_set_current_tabpage(current_tab) -- Return to the original tab
            end,
          },
        }
      }
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end
      
      treesitter.setup({
        ensure_installed = {
          "lua",
          "python", 
          "bash",
          "markdown",
          "json",
          "yaml",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end,
  },
  {
    "neko-night/nvim",
    name = "nekonight",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
  },
  { "ellisonleao/gruvbox.nvim" },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        color_icons = true,
        default = true,
        strict = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    opts = { style = "moon" },
  },
  {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v3.x",
   dependencies = {
     "nvim-lua/plenary.nvim",
     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
     "MunifTanjim/nui.nvim",
   },
   lazy = false, -- neo-tree will lazily load itself
   opts = {
   },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config('pylsp', {
        cmd = { 'pylsp' },
        root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
        settings = {
          pylsp = {
            plugins = {
              pycodestyle = {
                maxLineLength = 200,
              },
              flake8 = {
                maxLineLength = 200,
              }
            }
          }
        }
      })
  
      vim.lsp.enable('pylsp')
    end,
  },
  { "mason-org/mason.nvim", opts = {}, version = "^1.0.0" },
  { "datsfilipe/vesper.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "sainnhe/gruvbox-material" },
  { "lmantw/themify.nvim" },
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {"gruvbox", "gruvbox-material", "tokyonight-moon", "tokyonight-storm", "habamax", "monokai", "lunaperche", "murphy", "retrobox", "sorbet", "oxocarbon", "vesper", "nekonight-deep-ocean", "nekonight-aurora", "nekonight-synthwave", "nekonight-arcdark", "nekonight-material-theme", "nekonight-zenburn", "nekonight-doom-one", "nekonight-noctis-uva", "nekonight-fire-obsidian", "nekonight-mars", "nekonight-day"}
      })
    end
  },
  {
    'serenevoid/kiwi.nvim',
    opts = {
      {
          name = "vimwiki",
          path = "vimwiki"
      }
    },
    keys = {
      { "<leader>ww", ":lua require(\"kiwi\").open_wiki_index()<cr>", desc = "Open Wiki index" },
      { "<C-Space>", ":lua require(\"kiwi\").todo.toggle()<cr>", desc = "Toggle Markdown Task" }
    },
    lazy = true
  },
  { "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }
  },
  { "tanvirtin/monokai.nvim" },
  {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },

        version = "*",

        opts = {
            keymap = {
                preset = "enter",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            },

            appearance = {
                nerd_font_variant = "mono",
            },

            sources = {
                default = { "lsp", "path", "snippets", "buffer" },

            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
            completion = {
                keyword = { range = "prefix" },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
                trigger = { show_on_trigger_character = true },
                documentation = {
                    auto_show = true,
                },
            },

            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    }
})
