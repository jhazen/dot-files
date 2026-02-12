return {
  -- Markdown preview in browser
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle Markdown Preview" },
    },
  },

  -- Render markdown beautifully inside neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown" },
    opts = {
      heading = {
        enabled = true,
      },
      code = {
        enabled = true,
        style = "full",
      },
      checkbox = {
        enabled = true,
      },
    },
  },

  -- Table mode: easy markdown table creation and editing
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    config = function()
      vim.g.table_mode_corner = "|"
    end,
  },

  -- Pandoc integration: commands and keybindings for document conversion
  -- Easily modifiable — just change the pandoc command strings below
  {
    "nvim-lua/plenary.nvim", -- already a dependency, using it for the config function
    config = function()
      -- Check if pandoc is available
      local has_pandoc = vim.fn.executable("pandoc") == 1

      if not has_pandoc then
        vim.api.nvim_create_user_command("PandocPDF", function()
          vim.notify("pandoc not found. Install pandoc to use this feature.", vim.log.levels.WARN)
        end, { desc = "Convert to PDF (pandoc not found)" })
        return
      end

      -- Helper: run pandoc command asynchronously
      local function pandoc_convert(format, extra_args)
        local file = vim.fn.expand("%:p")
        local basename = vim.fn.expand("%:t:r")
        local dir = vim.fn.expand("%:p:h")
        local output_dir = dir .. "/output"

        -- Create output directory if it doesn't exist
        vim.fn.mkdir(output_dir, "p")

        local ext_map = {
          pdf = ".pdf",
          docx = ".docx",
          html = ".html",
          latex = ".tex",
          beamer = ".pdf",
        }

        local output_file = output_dir .. "/" .. basename .. (ext_map[format] or "." .. format)
        extra_args = extra_args or ""

        -- Base pandoc command — MODIFY THESE TEMPLATES AS NEEDED
        local cmd_templates = {
          pdf = string.format(
            'pandoc "%s" -o "%s" --pdf-engine=xelatex -V geometry:margin=1in %s',
            file, output_file, extra_args
          ),
          docx = string.format(
            'pandoc "%s" -o "%s" %s',
            file, output_file, extra_args
          ),
          html = string.format(
            'pandoc "%s" -o "%s" --standalone --self-contained %s',
            file, output_file, extra_args
          ),
          latex = string.format(
            'pandoc "%s" -o "%s" %s',
            file, output_file, extra_args
          ),
          beamer = string.format(
            'pandoc "%s" -o "%s" -t beamer %s',
            file, output_file, extra_args
          ),
        }

        local cmd = cmd_templates[format]
        if not cmd then
          vim.notify("Unknown format: " .. format, vim.log.levels.ERROR)
          return
        end

        vim.notify("Pandoc: converting to " .. format .. "...", vim.log.levels.INFO)

        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            vim.schedule(function()
              if exit_code == 0 then
                vim.notify("Pandoc: saved to " .. output_file, vim.log.levels.INFO)
              else
                vim.notify("Pandoc: conversion failed (exit code " .. exit_code .. ")", vim.log.levels.ERROR)
              end
            end)
          end,
          on_stderr = function(_, data)
            if data and data[1] ~= "" then
              vim.schedule(function()
                for _, line in ipairs(data) do
                  if line ~= "" then
                    vim.notify("Pandoc: " .. line, vim.log.levels.WARN)
                  end
                end
              end)
            end
          end,
        })
      end

      -- User commands
      vim.api.nvim_create_user_command("PandocPDF", function(opts)
        pandoc_convert("pdf", opts.args)
      end, { desc = "Convert markdown to PDF via pandoc", nargs = "?" })

      vim.api.nvim_create_user_command("PandocDOCX", function(opts)
        pandoc_convert("docx", opts.args)
      end, { desc = "Convert markdown to DOCX via pandoc", nargs = "?" })

      vim.api.nvim_create_user_command("PandocHTML", function(opts)
        pandoc_convert("html", opts.args)
      end, { desc = "Convert markdown to HTML via pandoc", nargs = "?" })

      vim.api.nvim_create_user_command("PandocLaTeX", function(opts)
        pandoc_convert("latex", opts.args)
      end, { desc = "Convert markdown to LaTeX via pandoc", nargs = "?" })

      vim.api.nvim_create_user_command("PandocBeamer", function(opts)
        pandoc_convert("beamer", opts.args)
      end, { desc = "Convert markdown to Beamer slides via pandoc", nargs = "?" })

      -- Custom pandoc command with full control
      vim.api.nvim_create_user_command("Pandoc", function(opts)
        local file = vim.fn.expand("%:p")
        local cmd = "pandoc " .. file .. " " .. opts.args
        vim.notify("Running: " .. cmd, vim.log.levels.INFO)
        vim.fn.jobstart(cmd, {
          on_exit = function(_, exit_code)
            vim.schedule(function()
              if exit_code == 0 then
                vim.notify("Pandoc: done", vim.log.levels.INFO)
              else
                vim.notify("Pandoc: failed (exit code " .. exit_code .. ")", vim.log.levels.ERROR)
              end
            end)
          end,
        })
      end, { desc = "Run custom pandoc command on current file", nargs = "+" })

      -- Markdown-specific keymaps for pandoc
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(args)
          local bopts = { buffer = args.buf, noremap = true, silent = true }
          vim.keymap.set("n", "<leader>bp", "<cmd>PandocPDF<cr>", vim.tbl_extend("force", bopts, { desc = "Pandoc → PDF" }))
          vim.keymap.set("n", "<leader>bd", "<cmd>PandocDOCX<cr>", vim.tbl_extend("force", bopts, { desc = "Pandoc → DOCX" }))
          vim.keymap.set("n", "<leader>bh", "<cmd>PandocHTML<cr>", vim.tbl_extend("force", bopts, { desc = "Pandoc → HTML" }))
          vim.keymap.set("n", "<leader>bl", "<cmd>PandocLaTeX<cr>", vim.tbl_extend("force", bopts, { desc = "Pandoc → LaTeX" }))
          vim.keymap.set("n", "<leader>bs", "<cmd>PandocBeamer<cr>", vim.tbl_extend("force", bopts, { desc = "Pandoc → Beamer slides" }))
        end,
      })
    end,
  },
}
