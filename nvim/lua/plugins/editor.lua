return {
  -- Treesitter: parser management and queries
  -- NOTE: The new nvim-treesitter (main branch) requires Neovim 0.11+
  -- Highlighting/indent are now built into Neovim via vim.treesitter.start()
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false, -- nvim-treesitter must not be lazy-loaded
    build = ":TSUpdate",
    config = function()
      -- Install parsers (async, no-op if already installed)
      require("nvim-treesitter").install({
        "lua",
        "python",
        "bash",
        "markdown",
        "markdown_inline",
        "json",
        "yaml",
        "c",
        "java",
        "javascript",
        "typescript",
        "html",
        "css",
        "go",
        "vim",
        "vimdoc",
        "regex",
        "diff",
        "gitcommit",
      })

      -- Enable treesitter highlighting and indentation for all supported filetypes
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- Try to start treesitter; silently fail for unsupported filetypes
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },

  -- Treesitter text objects: select, move, swap
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      })

      -- Select keymaps
      local select_textobject = function(query)
        return function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end
      end

      vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"), { desc = "outer function" })
      vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"), { desc = "inner function" })
      vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"), { desc = "outer class" })
      vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"), { desc = "inner class" })
      vim.keymap.set({ "x", "o" }, "aa", select_textobject("@parameter.outer"), { desc = "outer parameter" })
      vim.keymap.set({ "x", "o" }, "ia", select_textobject("@parameter.inner"), { desc = "inner parameter" })
      vim.keymap.set({ "x", "o" }, "ai", select_textobject("@conditional.outer"), { desc = "outer conditional" })
      vim.keymap.set({ "x", "o" }, "ii", select_textobject("@conditional.inner"), { desc = "inner conditional" })
      vim.keymap.set({ "x", "o" }, "al", select_textobject("@loop.outer"), { desc = "outer loop" })
      vim.keymap.set({ "x", "o" }, "il", select_textobject("@loop.inner"), { desc = "inner loop" })

      -- Move keymaps
      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end, { desc = "Next class start" })
      vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end, { desc = "Next parameter" })
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end, { desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end, { desc = "Next class end" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, { desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, { desc = "Prev class start" })
      vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end, { desc = "Prev parameter" })
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, { desc = "Prev function end" })
      vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, { desc = "Prev class end" })

      -- Swap keymaps
      vim.keymap.set("n", "<leader>a", function()
        require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>A", function()
        require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
      end, { desc = "Swap prev parameter" })
    end,
  },

  -- Flash: lightning-fast navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    },
  },

  -- Todo comments: highlight and search TODO/FIXME/HACK/NOTE
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    },
  },

  -- Comment.nvim: easy code commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- gcc to comment line, gc in visual mode
      -- gbc to block comment
    },
  },

  -- Auto pairs: auto-close brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true, -- use treesitter to check for pairs
    },
  },

  -- Surround: add/change/delete surrounding pairs
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  -- Undotree: visualize undo history
  {
    "mbbill/undotree",
    keys = {
      { "<C-u>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
        show_start = true,
      },
    },
  },

  -- Trouble: better diagnostics list
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
    },
  },

  -- WinShift: interactively move windows around with hjkl
  {
    "sindrets/winshift.nvim",
    opts = {
      highlight_moving_win = true,
      focused_hl_group = "Visual",
    },
    keys = {
      { "<leader>Wm", "<cmd>WinShift<cr>", desc = "Win-Move mode (hjkl to move)" },
      { "<leader>Ws", "<cmd>WinShift swap<cr>", desc = "Swap window (pick target)" },
    },
  },

  -- Ventana: transpose and rotate window layouts
  {
    "jyscao/ventana.nvim",
    keys = {
      { "<leader>Wt", "<cmd>VentanaTranspose<cr>", desc = "Transpose window layout" },
      { "<leader>Wr", "<cmd>VentanaShift<cr>", desc = "Rotate/shift windows" },
    },
  },
}
