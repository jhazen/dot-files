-- ============================================================================
-- Keymaps
-- ============================================================================
local opts = { noremap = true, silent = true }

-- ============================================================================
-- Window Navigation
-- ============================================================================
vim.keymap.set("n", ",h", "<C-w>h", opts)
vim.keymap.set("n", ",j", "<C-w>j", opts)
vim.keymap.set("n", ",k", "<C-w>k", opts)
vim.keymap.set("n", ",l", "<C-w>l", opts)
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Window movement (move window to position)
vim.keymap.set("n", ",K", "<C-w>K", opts)
vim.keymap.set("n", ",J", "<C-w>J", opts)
vim.keymap.set("n", ",H", "<C-w>H", opts)
vim.keymap.set("n", ",L", "<C-w>L", opts)

-- ============================================================================
-- Splits
-- ============================================================================
vim.keymap.set("n", "vv", ":vsplit<CR>", opts)
vim.keymap.set("n", "ss", ":split<CR>", opts)

-- Resize with leader + arrows
vim.keymap.set("n", "<leader><Up>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<leader><Down>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<leader><Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<leader><Right>", ":vertical resize +2<CR>", opts)

-- Resize with comma (ported from vimrc, 5 increments)
vim.keymap.set("n", ",e", "<C-w>+<C-w>+<C-w>+<C-w>+<C-w>+", opts)
vim.keymap.set("n", ",w", "<C-w>-<C-w>-<C-w>-<C-w>-<C-w>-", opts)
vim.keymap.set("n", ",q", "<C-w><<C-w><<C-w><<C-w><<C-w><", opts)
vim.keymap.set("n", ",r", "<C-w>><C-w>><C-w>><C-w>><C-w>>", opts)

-- ============================================================================
-- Tabs
-- ============================================================================
vim.keymap.set("n", "<C-t>", ":tabnew<CR>", opts)
vim.keymap.set("n", "<C-w>", ":tabprev<CR>", opts)
vim.keymap.set("n", "<C-e>", ":tabnext<CR>", opts)

-- Editor tab: new tab with Neotree + Aerial
vim.keymap.set("n", "<leader>T", function()
  vim.cmd("tabnew")
  vim.cmd("Neotree toggle")
  vim.cmd("wincmd l")
end, { desc = "New editor tab" })

-- ============================================================================
-- Buffers
-- ============================================================================
vim.keymap.set("n", "bn", ":bn<CR>", opts)
vim.keymap.set("n", "bp", ":bp<CR>", opts)

-- ============================================================================
-- Terminal keymaps (adapted for toggleterm + legacy support)
-- ============================================================================
-- Toggleterm: C-\ opens default terminal (configured in tools.lua)
-- These keymaps open specific terminal types using toggleterm numbered terminals
vim.keymap.set("n", "<C-b>", function()
  -- Open bash in horizontal split (terminal #2)
  require("toggleterm").toggle(2, 25, nil, "horizontal")
end, { desc = "Bash terminal (horizontal)", noremap = true, silent = true })

vim.keymap.set("n", "<C-p>", function()
  -- Open Python REPL via toggleterm (uses the custom python terminal from tools.lua)
  -- Fallback: numbered terminal #3 with python3
  local Terminal = require("toggleterm.terminal").Terminal
  local py = Terminal:new({ cmd = "python3", count = 3, direction = "horizontal" })
  py:toggle()
end, { desc = "Python REPL (horizontal)", noremap = true, silent = true })

vim.keymap.set("n", "<C-a>", function()
  -- Open cline in horizontal split (terminal #4)
  local Terminal = require("toggleterm.terminal").Terminal
  local cline = Terminal:new({ cmd = "cline", count = 4, direction = "horizontal" })
  cline:toggle()
end, { desc = "Cline terminal (horizontal)", noremap = true, silent = true })

-- Vertical split terminals (ported from vimrc)
vim.keymap.set("n", "bB", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local bash = Terminal:new({ count = 5, direction = "vertical" })
  bash:toggle()
end, { desc = "Bash terminal (vertical)", noremap = true, silent = true })

vim.keymap.set("n", "bP", function()
  local Terminal = require("toggleterm.terminal").Terminal
  local py = Terminal:new({ cmd = "python3", count = 6, direction = "vertical" })
  py:toggle()
end, { desc = "Python REPL (vertical)", noremap = true, silent = true })

-- Terminal mode: Escape to normal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], opts)

-- ============================================================================
-- File Explorer & Code Outline
-- ============================================================================
vim.keymap.set("n", "<C-n>", ":Neotree reveal<CR>", opts)
vim.keymap.set("n", "<C-g>", ":AerialToggle right<CR>", opts)

-- ============================================================================
-- Telescope (fuzzy finder)
-- ============================================================================
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>ft", ":Telescope lsp_document_symbols<CR>", opts)
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<leader>sw", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "[S]earch [W]ord under cursor" })

-- ============================================================================
-- LSP keymaps (also set in lsp.lua on LspAttach, these are global fallbacks)
-- ============================================================================
vim.keymap.set("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

-- ============================================================================
-- Git (Fugitive)
-- ============================================================================
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status"})
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", opts)
vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", opts)
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", opts)
vim.keymap.set("n", "<leader>cd", ":Glcd<CR>", opts)

-- ============================================================================
-- Colorscheme
-- ============================================================================
vim.keymap.set("n", "<leader>cc", ":Themery<CR>", opts)

-- ============================================================================
-- Macros (kept from vimrc)
-- ============================================================================
-- @q macro: prepend # to line and move down (used for commenting and other things)
vim.fn.setreg("q", "\x1b^i#\x1bj")
vim.keymap.set("n", "<Space>", "@q", { desc = "Run macro q" })
vim.keymap.set("n", "<leader><Space>", "@q@q@q@q@q@q@q@q@q@q", { desc = "Run macro q x10" })

-- ============================================================================
-- Folding
-- ============================================================================
vim.keymap.set("n", "<C-f>", "za", opts)

-- ============================================================================
-- Misc
-- ============================================================================
-- Copy current file:line to clipboard
vim.keymap.set("n", "<leader>W", ":let @+ = expand('%') . ':' . line('.')<CR>", opts)

-- Prepend todo checkbox to current line
vim.keymap.set("n", "tt", function()
  vim.cmd("normal! ^I- [ ] ")
end, { desc = "Prepend todo checkbox" })

-- ============================================================================
-- Markdown-specific keymaps (spell, wiki)
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    local bopts = { buffer = args.buf, noremap = true, silent = true }
    -- Spell checking
    vim.keymap.set("n", "<leader>con", ":set spell spelllang=en_us<CR>", vim.tbl_extend("force", bopts, { desc = "Spell on" }))
    vim.keymap.set("n", "<leader>coff", ":set nospell<CR>", vim.tbl_extend("force", bopts, { desc = "Spell off" }))
    vim.keymap.set("n", "<leader>cn", "]s", vim.tbl_extend("force", bopts, { desc = "Next misspelling" }))
    vim.keymap.set("n", "<leader>cp", "[s", vim.tbl_extend("force", bopts, { desc = "Prev misspelling" }))
    vim.keymap.set("n", "<leader>cf", "z=", vim.tbl_extend("force", bopts, { desc = "Fix spelling" }))
    vim.keymap.set("n", "<leader>ca", "zg", vim.tbl_extend("force", bopts, { desc = "Add to dictionary" }))
    -- Wiki navigation
    vim.keymap.set("n", "<Backspace>", ":lua require('kiwi').open_wiki_index()<CR>", vim.tbl_extend("force", bopts, { desc = "Wiki index" }))
  end,
})

-- ============================================================================
-- Workspace macros (ported from vimrc, adapted for new plugins)
-- ============================================================================

-- Code Editor layout: wiki tab + terminal tab + 3 editor tabs
vim.keymap.set("n", "<leader>E", function()
  -- Tab 1: Wiki (already opened by suave restore)
  -- Tab 2: Terminal
  vim.cmd("tabnew")
  vim.cmd("terminal")
  vim.cmd("startinsert")
  vim.cmd("stopinsert")
  -- Tab 3-5: Editor tabs with Neotree
  for _ = 1, 3 do
    vim.cmd("tabnew")
    vim.cmd("Neotree toggle")
    vim.cmd("wincmd l")
  end
  -- Go to tab 2 (first editor tab after wiki)
  vim.cmd("tabnext 2")
end, { desc = "Code Editor layout" })

-- Writing layout: wiki tab + 3 editor tabs (no line numbers)
vim.keymap.set("n", "<leader>WL", function()
  for _ = 1, 3 do
    vim.cmd("tabnew")
    vim.cmd("set nonumber norelativenumber")
    vim.cmd("Neotree toggle")
    vim.cmd("wincmd l")
  end
  vim.cmd("tabnext 2")
end, { desc = "Writing layout" })

-- ============================================================================
-- Shortcut reference window (updated with new keybindings)
-- ============================================================================
local function create_floating_window()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "═══════════════════════════════════════",
    "         KEYBINDING REFERENCE          ",
    "═══════════════════════════════════════",
    "",
    "── Terminals ──────────────────────────",
    "C-\\    Toggle terminal (toggleterm)",
    "C-b    Bash (horizontal)",
    "C-p    Python REPL (horizontal)",
    "C-a    Cline (horizontal)",
    "bB     Bash (vertical)",
    "bP     Python (vertical)",
    "\\tf   Floating terminal",
    "\\tp   Python REPL (toggleterm)",
    "\\ts   Send selection to terminal (V)",
    "",
    "── Navigation ─────────────────────────",
    "C-n    Neotree",
    "C-g    Aerial (code outline)",
    "C-u    Undotree",
    "-      Oil (file manager)",
    "s      Flash jump",
    "S      Flash treesitter",
    "",
    "── Telescope ──────────────────────────",
    "\\ff   Find files",
    "\\fg   Live grep",
    "\\fb   Buffers",
    "\\ft   LSP symbols",
    "\\fh   Help tags",
    "\\fr   Recent files",
    "\\fT   Find TODOs",
    "\\sw   Search word under cursor",
    "",
    "── LSP ────────────────────────────────",
    "gd     Go to definition",
    "gr     References",
    "gi     Implementation",
    "K      Hover docs",
    "C-k    Signature help",
    "SPC rn Rename",
    "SPC ca Code action",
    "SPC f  Format",
    "",
    "── Debugger (DAP) ─────────────────────",
    "\\du   Toggle DAP UI",
    "\\db   Toggle breakpoint",
    "\\dB   Conditional breakpoint",
    "\\dc   Continue",
    "\\di   Step into",
    "\\do   Step over",
    "\\dO   Step out",
    "\\dT   Terminate",
    "\\de   Eval expression",
    "",
    "── Git ────────────────────────────────",
    "\\gs   Git status",
    "\\gc   Git commit",
    "\\gp   Git pull",
    "\\gb   Git blame",
    "]h     Next hunk",
    "[h     Prev hunk",
    "\\hs   Stage hunk",
    "\\hp   Preview hunk",
    "",
    "── Diagnostics ────────────────────────",
    "\\xx   Toggle Trouble",
    "\\xX   Buffer diagnostics",
    "\\xt   Todo list",
    "\\cl   Trigger lint",
    "\\cf   Format buffer",
    "",
    "── Markdown / Pandoc ──────────────────",
    "\\bp   Pandoc → PDF",
    "\\bd   Pandoc → DOCX",
    "\\bh   Pandoc → HTML",
    "\\mp   Markdown preview (browser)",
    "\\ww   Wiki index",
    "C-Space Toggle todo checkbox",
    "",
    "── Snyk ───────────────────────────────",
    "\\sk   Snyk test",
    "\\sK   Snyk code test",
    "",
    "── Layouts ────────────────────────────",
    "\\E    Code Editor layout",
    "\\H    Pentest Editor layout",
    "\\WL   Writing layout",
    "\\T    New editor tab",
    "",
    "── Misc ───────────────────────────────",
    "\\c    Colorscheme picker",
    "\\?    Which-key (buffer keymaps)",
    "\\W    Copy file:line to clipboard",
    "gcc    Comment line (Comment.nvim)",
    "gc     Comment selection (visual)",
    "za/C-f Fold toggle",
    "Space  Run @q macro",
    "tt     Prepend todo checkbox",
  })

  local wopts = {
    relative = "editor",
    width = 50,
    height = math.min(vim.o.lines - 4, 95),
    col = math.floor((vim.o.columns / 2) - 25),
    row = 1,
    anchor = "NW",
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, wopts)
  vim.api.nvim_win_set_option(win, "winblend", 10)

  -- Close with q or Escape
  vim.keymap.set("n", "q", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, noremap = true, silent = true })
  vim.keymap.set("n", "<Esc>", function()
    vim.api.nvim_win_close(win, true)
  end, { buffer = buf, noremap = true, silent = true })
end

vim.keymap.set("n", "<leader>=", create_floating_window, { desc = "Keybinding reference" })

-- ============================================================================
-- Visual mode
-- ============================================================================
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
