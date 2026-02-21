return {
  -- Conform: formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        python = { "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        bash = { "shfmt" },
        java = { "google-java-format" },
        lua = { "stylua" },
        rust = { "rustfmt" },
      },
      -- Uncomment to enable format on save:
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" }, -- 2-space indent for shell scripts
        },
        black = {
          prepend_args = { "--line-length", "120" },
        },
      },
    },
    init = function()
      -- Use conform for gq formatting
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")
  
      lint.linters_by_ft = {
        python = { "ruff", "bandit" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        markdown = { "markdownlint" },
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
      }
  
      -- Configure bandit for security-focused Python linting
      lint.linters.bandit = {
        cmd = "bandit",
        stdin = false,
        args = { "-f", "json", "-ll" },
        stream = "stdout",
        ignore_exitcode = true,
        parser = function(output, bufnr)
          local diagnostics = {}
          if output == "" then 
            print("Bandit: No output received")
            return diagnostics 
          end
  
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok then 
            print("Bandit: Failed to decode JSON: " .. output:sub(1, 100))
            return diagnostics 
          end
  
          local results = decoded.results or {}
          print("Bandit: Found " .. #results .. " issues")
  
          for _, result in ipairs(results) do
            table.insert(diagnostics, {
              lnum = (result.line_number or 1) - 1,
              col = 0,
              end_lnum = (result.line_range and result.line_range[#result.line_range] or result.line_number or 1) - 1,
              severity = ({
                LOW = vim.diagnostic.severity.INFO,
                MEDIUM = vim.diagnostic.severity.WARN,
                HIGH = vim.diagnostic.severity.ERROR,
              })[result.issue_severity] or vim.diagnostic.severity.WARN,
              message = string.format("[%s] %s (Confidence: %s)", 
                result.test_id or "B???", 
                result.issue_text or "Unknown", 
                result.issue_confidence or "?"),
              source = "bandit",
            })
          end
          return diagnostics
        end,
      }
  
      -- Auto-lint on events
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        callback = function()
          local ft = vim.bo.filetype
          local linters = lint.linters_by_ft[ft]
          if linters then
            lint.try_lint()
          end
        end,
      })
  
      -- Manual lint command
      vim.api.nvim_create_user_command("Lint", function()
        print("Running linters for " .. vim.bo.filetype)
        lint.try_lint()
      end, { desc = "Trigger linting for current file" })
  
      vim.keymap.set("n", "<leader>cl", function()
        lint.try_lint()
        vim.defer_fn(function()
          local diagnostics = vim.diagnostic.get(0)
          local bandit_items = {}
          for _, d in ipairs(diagnostics) do
            if d.source == "bandit" then
              table.insert(bandit_items, {
                bufnr = vim.api.nvim_get_current_buf(),
                lnum = d.lnum + 1,
                col = d.col + 1,
                text = d.message,
                type = d.severity == vim.diagnostic.severity.ERROR and "E" or "W",
              })
            end
          end
          vim.fn.setqflist(bandit_items)
          if #bandit_items > 0 then
            vim.cmd("copen")
          else
            print("✅ No bandit issues found")
          end
        end, 1000)
      end, { desc = "Lint and show Bandit results" })
    end,
  },
  -- Mason tool installer: ensure linters and formatters are installed
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters
        "black",
        "prettier",
        "shfmt",
        "stylua",
        "clang-format",
        -- Linters
        "ruff",
        "shellcheck",
        "markdownlint",
        -- Note: bandit and google-java-format may need manual install via pip/system
        -- pip install bandit
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
