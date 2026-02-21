return {
  -- Blink.cmp: fast completion engine
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
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
      fuzzy = { implementation = "lua" },
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
  },

  -- Lazydev: better Lua/Neovim API completions when editing config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Crates.nvim: Cargo.toml dependency management and completion
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
          max_results = 8,
          min_chars = 3,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
    keys = {
      { "<leader>rCt", function() require("crates").toggle() end, desc = "Toggle crate info" },
      { "<leader>rCv", function() require("crates").show_versions_popup() end, desc = "Crate versions" },
      { "<leader>rCf", function() require("crates").show_features_popup() end, desc = "Crate features" },
      { "<leader>rCd", function() require("crates").show_dependencies_popup() end, desc = "Crate dependencies" },
      { "<leader>rCu", function() require("crates").update_crate() end, desc = "Update crate" },
      { "<leader>rCa", function() require("crates").update_all_crates() end, desc = "Update all crates" },
      { "<leader>rCH", function() require("crates").open_homepage() end, desc = "Crate homepage" },
      { "<leader>rCR", function() require("crates").open_repository() end, desc = "Crate repository" },
      { "<leader>rCD", function() require("crates").open_documentation() end, desc = "Crate documentation" },
      { "<leader>rCC", function() require("crates").open_crates_io() end, desc = "Open crates.io" },
    },
  },
}
