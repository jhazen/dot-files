return {
  -- Mason: portable package manager for LSP servers, DAP servers, linters, formatters
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- Bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "pyright",        -- Python
        "bashls",         -- Bash
        "clangd",         -- C/C++
        "ts_ls",          -- JavaScript/TypeScript
        "jdtls",          -- Java
        "asm_lsp",        -- x86 Assembly
        "lua_ls",         -- Lua (for neovim config editing)
      },
      automatic_installation = true,
    },
  },

-- LSP Configuration
{
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
  },
  config = function()
    -- Check nvim version and use appropriate API
    local nvim_0_11 = vim.fn.has('nvim-0.11') == 1
    
    if nvim_0_11 then
      -- New API for nvim 0.11+
      local servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        bashls = {},
        clangd = {
          cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
        },
        ts_ls = {},
        jdtls = {},
        asm_lsp = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }
      
      -- Configure each server with new API
      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    else
      -- Old API for nvim < 0.11
      local lspconfig = require("lspconfig")

      -- Python (pyright)
      lspconfig.pyright.setup({
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      -- Bash
      lspconfig.bashls.setup({})

      -- C/C++
      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      })

      -- JavaScript/TypeScript
      lspconfig.ts_ls.setup({})

      -- Java
      lspconfig.jdtls.setup({})

      -- x86 Assembly
      lspconfig.asm_lsp.setup({})

      -- Lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
    end

    -- LSP Attach keymaps
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local keymap = vim.keymap
        local lsp = vim.lsp
        local bufopts = { noremap = true, silent = true, buffer = args.buf }

        keymap.set("n", "gr", lsp.buf.references, bufopts)
        keymap.set("n", "gd", lsp.buf.definition, bufopts)
        keymap.set("n", "gD", lsp.buf.declaration, bufopts)
        keymap.set("n", "gi", lsp.buf.implementation, bufopts)
        keymap.set("n", "<space>rn", lsp.buf.rename, bufopts)
        keymap.set("n", "<space>ca", lsp.buf.code_action, bufopts)
        keymap.set("n", "K", lsp.buf.hover, bufopts)
        keymap.set("n", "<C-k>", lsp.buf.signature_help, bufopts)
        keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)
        keymap.set("n", "<space>D", lsp.buf.type_definition, bufopts)
      end,
    })
  end,
},}
