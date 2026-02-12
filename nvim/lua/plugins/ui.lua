return {
  -- Colorschemes
  {
    "neko-night/nvim",
    name = "nekonight",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim", opts = { style = "moon" } },
  { "datsfilipe/vesper.nvim" },
  { "nyoom-engineering/oxocarbon.nvim" },
  { "sainnhe/gruvbox-material" },
  { "tanvirtin/monokai.nvim" },
  { "lmantw/themify.nvim" },

  -- Colorscheme picker
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          "gruvbox",
          "gruvbox-material",
          "tokyonight-moon",
          "tokyonight-storm",
          "habamax",
          "monokai",
          "lunaperche",
          "murphy",
          "retrobox",
          "sorbet",
          "oxocarbon",
          "vesper",
          "nekonight-deep-ocean",
          "nekonight-aurora",
          "nekonight-synthwave",
          "nekonight-arcdark",
          "nekonight-material-theme",
          "nekonight-zenburn",
          "nekonight-doom-one",
          "nekonight-noctis-uva",
          "nekonight-fire-obsidian",
          "nekonight-mars",
          "nekonight-day",
        },
      })
    end,
  },

  -- Default colorscheme
  {
    "nyoom-engineering/oxocarbon.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Set default colorscheme (suave will override if session exists)
      local is_ok, _ = pcall(vim.cmd, "colorscheme oxocarbon")
      if not is_ok then
        vim.notify("colorscheme oxocarbon not found!", vim.log.levels.WARN)
      end
    end,
  },

  -- Lualine: statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- Neo-tree: file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    lazy = false,
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
    },
  },

  -- Web devicons
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

  -- Aerial: code outline / tagbar replacement
  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- Which-key: show available keybindings
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        marks = true,
        registers = true,
        spelling = { enabled = true, suggestions = 20 },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
