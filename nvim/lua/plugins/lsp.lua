-- Detect if running on macOS
local is_mac = vim.fn.has("macunix") == 1

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
        is_mac and "pylsp" or "pyright",  -- Python (pylsp on Mac, pyright elsewhere)
        "bashls",         -- Bash
        "clangd",         -- C/C++
        "ts_ls",          -- JavaScript/TypeScript
        "jdtls",          -- Java
        "asm_lsp",        -- x86 Assembly
        "lua_ls",         -- Lua (for neovim config editing)
        "rust_analyzer",  -- Rust (setup managed by rustaceans.nvim)
      },
      automatic_installation = true,
      -- Exclude rust_analyzer from automatic lspconfig setup;
      -- rustaceans.nvim manages the rust-analyzer lifecycle and configuration
      automatic_enable = {
        exclude = { "rust_analyzer" },
      },
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
    
    -- Reuse the is_mac check (module-level local)
    local is_mac = vim.fn.has("macunix") == 1

    if nvim_0_11 then
      -- New API for nvim 0.11+
      local servers = {
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

      -- Python: use pylsp on Mac, pyright elsewhere
      if is_mac then
        servers.pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { maxLineLength = 120 },
              },
            },
          },
        }
      else
        servers.pyright = {
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
        }
      end

      -- Configure each server with new API
      for server, config in pairs(servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
    else
      -- Old API for nvim < 0.11
      local lspconfig = require("lspconfig")

      -- Python: use pylsp on Mac, pyright elsewhere
      if is_mac then
        lspconfig.pylsp.setup({
          settings = {
            pylsp = {
              plugins = {
                pycodestyle = { maxLineLength = 120 },
              },
            },
          },
        })
      else
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
      end

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

        keymap.set("n", "gr", lsp.buf.references, vim.tbl_extend("force", bufopts, { desc = "References" }))
        keymap.set("n", "gd", lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Go to definition" }))
        keymap.set("n", "gD", lsp.buf.declaration, vim.tbl_extend("force", bufopts, { desc = "Go to declaration" }))
        keymap.set("n", "gi", lsp.buf.implementation, vim.tbl_extend("force", bufopts, { desc = "Go to implementation" }))
        keymap.set("n", "K", lsp.buf.hover, vim.tbl_extend("force", bufopts, { desc = "Hover docs" }))
        keymap.set("n", "<C-k>", lsp.buf.signature_help, vim.tbl_extend("force", bufopts, { desc = "Signature help" }))
        keymap.set("n", "<leader>lr", lsp.buf.rename, vim.tbl_extend("force", bufopts, { desc = "Rename symbol" }))
        keymap.set("n", "<leader>la", lsp.buf.code_action, vim.tbl_extend("force", bufopts, { desc = "Code action" }))
        keymap.set("n", "<leader>lf", function()
          vim.lsp.buf.format({ async = true })
        end, vim.tbl_extend("force", bufopts, { desc = "LSP format" }))
        keymap.set("n", "<leader>lD", lsp.buf.type_definition, vim.tbl_extend("force", bufopts, { desc = "Type definition" }))
      end,
    })
  end,
},}
