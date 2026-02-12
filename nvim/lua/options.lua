-- ============================================================================
-- Core Options
-- ============================================================================

-- Clipboard
vim.opt.clipboard = "unnamedplus" -- use system clipboard

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Mouse
vim.opt.mouse = "a" -- allow the mouse to be used in Nvim

-- ============================================================================
-- Tab / Indent
-- ============================================================================
vim.opt.tabstop = 4        -- number of visual spaces per TAB
vim.opt.softtabstop = 4    -- number of spaces in tab when editing
vim.opt.shiftwidth = 4     -- insert 4 spaces on a tab
vim.opt.expandtab = true   -- tabs are spaces
vim.opt.smartindent = true  -- smart auto-indenting for C-like languages
vim.opt.autoindent = true   -- copy indent from previous line

-- ============================================================================
-- UI Config
-- ============================================================================
vim.opt.number = true          -- show absolute number
vim.opt.relativenumber = true  -- add relative numbers
vim.opt.cursorline = true      -- highlight cursor line
vim.opt.splitbelow = true      -- open new vertical split bottom
vim.opt.splitright = true      -- open new horizontal splits right
vim.opt.termguicolors = true   -- enable 24-bit RGB color in the TUI
vim.opt.showmode = false       -- don't show "-- INSERT --" mode hint
vim.opt.signcolumn = "yes"     -- always show sign column
vim.opt.scrolloff = 8          -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 15     -- keep 15 columns left/right of cursor
vim.opt.wrap = false           -- don't wrap lines by default
vim.opt.linebreak = true       -- wrap at word boundaries when wrap is on

-- ============================================================================
-- Searching
-- ============================================================================
vim.opt.incsearch = true   -- search as characters are entered
vim.opt.hlsearch = false   -- do not highlight matches
vim.opt.ignorecase = true  -- ignore case in searches by default
vim.opt.smartcase = true   -- but make it case sensitive if an uppercase is entered

-- ============================================================================
-- File handling
-- ============================================================================
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true    -- persistent undo
vim.opt.undodir = vim.fn.expand("~/.local/share/nvim/undodir")
vim.opt.autoread = true    -- auto-reload files changed outside vim
vim.opt.hidden = true      -- allow hidden buffers
vim.opt.fileformat = "unix"
vim.opt.encoding = "utf-8"

-- ============================================================================
-- Filetype-specific indent settings (ported from vimrc)
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "css", "html", "javascript", "typescript", "json", "yaml", "yml", "sls" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- ============================================================================
-- Markdown settings
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.breakindent = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.opt_local.spellfile = vim.fn.expand("~/en.utf-8.add")
  end,
})

-- ============================================================================
-- Assembly filetype detection
-- ============================================================================
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.asm", "*.z80", "*.s" },
  callback = function()
    vim.bo.filetype = "asm"
  end,
})

-- ============================================================================
-- FormatJSON command (ported from vimrc)
-- ============================================================================
vim.api.nvim_create_user_command("FormatJSON", function()
  -- Convert Python-style to JSON-style
  vim.cmd([[%s/'/"/ge]])
  vim.cmd([[%s/None/null/ge]])
  vim.cmd([[%s/False/false/ge]])
  vim.cmd([[%s/True/true/ge]])
  vim.cmd([[%!python3 -m json.tool]])
end, { desc = "Format buffer as JSON (handles Python dict syntax)" })

-- ============================================================================
-- Terminal settings
-- ============================================================================
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
