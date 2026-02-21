return {
  -- Core DAP
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dT", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "Open REPL" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>de", function() require("dap.ui.widgets").hover() end, desc = "Eval Expression", mode = { "n", "v" } },
    },
  },

  -- Mason DAP bridge
  {
    "jay-babu/mason-nvim-dap.nvim",
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
      "mason-org/mason.nvim",
    },
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    config = true,
    keys = {
      { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
    },
    dependencies = {
      "jay-babu/mason-nvim-dap.nvim",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
  },

  -- DAP Virtual Text (show variable values inline)
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    opts = {
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
    },
  },

  -- Python DAP
  {
    "mfussenegger/nvim-dap-python",
    lazy = true,
    config = function()
      local python = vim.fn.expand("/usr/bin/python3")
      require("dap-python").setup(python)
    end,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  -- Go DAP
  {
    "leoluz/nvim-dap-go",
    lazy = true,
    config = true,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },

  -- Rust: rustaceanvim (enhanced LSP + DAP via codelldb)
  -- Manages rust-analyzer and DAP debugging in one plugin
  -- DAP auto-detects codelldb from Mason or PATH
  {
    "mrcjkb/rustaceanvim",
    version = "^8",
    lazy = false, -- plugin is already lazy by filetype
    init = function()
      vim.g.rustaceanvim = {
        -- LSP configuration (rust-analyzer)
        server = {
          on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }

            -- Rust-specific keymaps (under <leader>r prefix)
            vim.keymap.set("n", "<leader>rr", function() vim.cmd.RustLsp("runnables") end,
              vim.tbl_extend("force", bufopts, { desc = "Rust runnables" }))
            vim.keymap.set("n", "<leader>rd", function() vim.cmd.RustLsp("debuggables") end,
              vim.tbl_extend("force", bufopts, { desc = "Rust debuggables" }))
            vim.keymap.set("n", "<leader>rt", function() vim.cmd.RustLsp("testables") end,
              vim.tbl_extend("force", bufopts, { desc = "Rust testables" }))
            vim.keymap.set("n", "<leader>rm", function() vim.cmd.RustLsp("expandMacro") end,
              vim.tbl_extend("force", bufopts, { desc = "Expand macro" }))
            vim.keymap.set("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end,
              vim.tbl_extend("force", bufopts, { desc = "Open Cargo.toml" }))
            vim.keymap.set("n", "<leader>rp", function() vim.cmd.RustLsp("parentModule") end,
              vim.tbl_extend("force", bufopts, { desc = "Parent module" }))
            vim.keymap.set("n", "<leader>rj", function() vim.cmd.RustLsp("joinLines") end,
              vim.tbl_extend("force", bufopts, { desc = "Join lines" }))
            vim.keymap.set("n", "<leader>rh", function() vim.cmd.RustLsp({ "hover", "actions" }) end,
              vim.tbl_extend("force", bufopts, { desc = "Hover actions" }))
            vim.keymap.set("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end,
              vim.tbl_extend("force", bufopts, { desc = "Explain error" }))
            vim.keymap.set("n", "<leader>rD", function() vim.cmd.RustLsp("renderDiagnostic") end,
              vim.tbl_extend("force", bufopts, { desc = "Render diagnostic" }))
            vim.keymap.set("n", "<leader>ro", function() vim.cmd.RustLsp("openDocs") end,
              vim.tbl_extend("force", bufopts, { desc = "Open docs.rs" }))
            vim.keymap.set("n", "<leader>ra", function() vim.cmd.RustLsp("codeAction") end,
              vim.tbl_extend("force", bufopts, { desc = "Rust code action" }))
          end,
          default_settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              checkOnSave = true,
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
                ignored = {
                  ["async-trait"] = { "async_trait" },
                  ["napi-derive"] = { "napi" },
                  ["async-recursion"] = { "async_recursion" },
                },
              },
              inlayHints = {
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                parameterHints = { enable = true },
                typeHints = { enable = true },
              },
            },
          },
        },
        -- DAP: auto-detects codelldb from Mason or PATH
      }
    end,
  },
}
