return {
  -- Fugitive: Git integration
  { url = "https://github.com/tpope/vim-fugitive" },

  -- Gitsigns: git diff in sign column, inline blame, hunk operations
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      current_line_blame = false, -- toggle with :Gitsigns toggle_current_line_blame
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end
        -- Navigation
        map("n", "]h", gs.next_hunk, { desc = "Next Hunk" })
        map("n", "[h", gs.prev_hunk, { desc = "Prev Hunk" })
        -- Actions
        map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage Hunk" })
        map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset Hunk" })
        map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage Buffer" })
        map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset Buffer" })
        map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview Hunk" })
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, { desc = "Blame Line" })
        map("n", "<leader>hd", gs.diffthis, { desc = "Diff This" })
        map("n", "<leader>htb", gs.toggle_current_line_blame, { desc = "Toggle Blame" })
      end,
    },
  },

  -- Suave: session/workspace persistence
  {
    "nyngwang/suave.lua",
    config = function()
      require("suave").setup({
        auto_save = {
          enabled = true,
        },
        store_hooks = {
          before_mksession = {
            function()
              -- Close neo-tree before saving session
              for _, w in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(w), "ft") == "neo-tree" then
                  vim.api.nvim_win_close(w, false)
                end
              end
            end,
          },
          after_mksession = {
            function(data)
              data.colorscheme = vim.g.colors_name
            end,
          },
        },
        restore_hooks = {
          after_source = {
            function(data)
              if not data then return end
              vim.cmd(string.format([[
                color %s
                doau ColorScheme %s
              ]], data.colorscheme, data.colorscheme))
            end,
            function(data)
              if not data then return end
              local current_tab = vim.api.nvim_get_current_tabpage()
              for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
                vim.api.nvim_set_current_tabpage(tab_id)
                vim.cmd("filetype detect")
              end
              vim.api.nvim_set_current_tabpage(current_tab)
            end,
            function(data)
              if not data then return end
              local current_tab = vim.api.nvim_get_current_tabpage()
              vim.cmd("tabfirst")
              vim.cmd('lua require("kiwi").open_wiki_index()')
              vim.api.nvim_set_current_tabpage(current_tab)
            end,
          },
        },
      })
    end,
  },

  -- Kiwi: wiki/markdown task management
  {
    "serenevoid/kiwi.nvim",
    opts = {
      {
        name = "vimwiki",
        path = "vimwiki",
      },
    },
    keys = {
      { "<leader>ww", ':lua require("kiwi").open_wiki_index()<cr>', desc = "Open Wiki index" },
      { "<C-Space>", ':lua require("kiwi").todo.toggle()<cr>', desc = "Toggle Markdown Task" },
    },
    lazy = true,
  },

  -- Telescope: fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Toggleterm: better terminal management
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 25
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
        },
      })

      -- Custom terminals
      local Terminal = require("toggleterm.terminal").Terminal

      -- Floating terminal
      local float_term = Terminal:new({
        direction = "float",
        float_opts = { border = "double" },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Python REPL terminal
      local python_term = Terminal:new({
        cmd = "python3",
        direction = "horizontal",
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Snyk terminal (if snyk is available)
      local snyk_test = Terminal:new({
        cmd = "snyk test 2>&1; echo '---'; echo 'Press q to close'; read -n1",
        direction = "float",
        float_opts = { border = "double", width = 120, height = 40 },
        close_on_exit = false,
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      local snyk_code = Terminal:new({
        cmd = "snyk code test 2>&1; echo '---'; echo 'Press q to close'; read -n1",
        direction = "float",
        float_opts = { border = "double", width = 120, height = 40 },
        close_on_exit = false,
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      -- Keymaps for custom terminals
      vim.keymap.set("n", "<leader>tf", function() float_term:toggle() end, { desc = "Toggle floating terminal", noremap = true, silent = true })
      vim.keymap.set("n", "<leader>tp", function() python_term:toggle() end, { desc = "Toggle Python REPL", noremap = true, silent = true })

      -- Snyk commands and keymaps
      vim.api.nvim_create_user_command("Snyk", function()
        if vim.fn.executable("snyk") == 1 then
          snyk_test:toggle()
        else
          vim.notify("snyk CLI not found. Install with: npm install -g snyk", vim.log.levels.WARN)
        end
      end, { desc = "Run Snyk test" })

      vim.api.nvim_create_user_command("SnykCode", function()
        if vim.fn.executable("snyk") == 1 then
          snyk_code:toggle()
        else
          vim.notify("snyk CLI not found. Install with: npm install -g snyk", vim.log.levels.WARN)
        end
      end, { desc = "Run Snyk code test" })

      vim.keymap.set("n", "<leader>sk", "<cmd>Snyk<cr>", { desc = "Snyk test", noremap = true, silent = true })
      vim.keymap.set("n", "<leader>sK", "<cmd>SnykCode<cr>", { desc = "Snyk code test", noremap = true, silent = true })

      -- Send visual selection to terminal
      vim.keymap.set("v", "<leader>ts", function()
        require("toggleterm").send_lines_to_terminal("visual_selection", true, { args = vim.v.count })
      end, { desc = "Send selection to terminal" })

      -- Terminal mode escape
      function _G.set_terminal_keymaps()
        local topts = { buffer = 0 }
        vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], topts)
        vim.keymap.set("t", ",h", [[<C-\><C-n><C-w>h]], topts)
        vim.keymap.set("t", ",j", [[<C-\><C-n><C-w>j]], topts)
        vim.keymap.set("t", ",k", [[<C-\><C-n><C-w>k]], topts)
        vim.keymap.set("t", ",l", [[<C-\><C-n><C-w>l]], topts)
      end

      -- Apply navigation keymaps to toggleterm terminals
      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")

      -- Apply the same navigation keymaps to ALL native term:// buffers
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "term://*",
        callback = function()
          set_terminal_keymaps()
        end,
      })
    end,
  },

  -- Oil: file manager as a buffer
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false, -- don't replace netrw (neo-tree handles that)
      view_options = {
        show_hidden = true,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    },
  },

  -- Hex editor: automatic hex editing for binary files
  {
    "RaafatTurki/hex.nvim",
    config = true,
  },
}
