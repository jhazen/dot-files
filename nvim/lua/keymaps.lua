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

-- Neo-tree: additional views
vim.keymap.set("n", "<leader>ng", ":Neotree git_status<CR>", { desc = "Neotree git status" })
vim.keymap.set("n", "<leader>nb", ":Neotree buffers<CR>", { desc = "Neotree buffers" })
vim.keymap.set("n", "<leader>nf", ":Neotree float<CR>", { desc = "Neotree float" })

-- Aerial / Outline
vim.keymap.set("n", "<leader>oo", ":AerialToggle right<CR>", { desc = "Toggle outline" })
vim.keymap.set("n", "<leader>on", ":AerialNavToggle<CR>", { desc = "Outline nav window" })
vim.keymap.set("n", "]s", ":AerialNext<CR>", { desc = "Next aerial symbol" })
vim.keymap.set("n", "[s", ":AerialPrev<CR>", { desc = "Prev aerial symbol" })

-- ============================================================================
-- Telescope (fuzzy finder)
-- ============================================================================
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>ft", ":Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>fr", ":Telescope oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fw", function()
  require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>") })
end, { desc = "Search word under cursor" })

-- Telescope: git pickers
vim.keymap.set("n", "<leader>fgc", ":Telescope git_commits<CR>", { desc = "Git commits" })
vim.keymap.set("n", "<leader>fgb", ":Telescope git_branches<CR>", { desc = "Git branches" })
vim.keymap.set("n", "<leader>fgs", ":Telescope git_status<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>fgS", ":Telescope git_stash<CR>", { desc = "Git stash" })

-- Telescope: additional pickers
vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
vim.keymap.set("n", "<leader>f:", ":Telescope command_history<CR>", { desc = "Command history" })
vim.keymap.set("n", "<leader>f/", ":Telescope search_history<CR>", { desc = "Search history" })
vim.keymap.set("n", "<leader>fm", ":Telescope marks<CR>", { desc = "Marks" })
vim.keymap.set("n", "<leader>f\"", ":Telescope registers<CR>", { desc = "Registers" })
vim.keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fS", ":Telescope lsp_dynamic_workspace_symbols<CR>", { desc = "Workspace symbols" })
vim.keymap.set("n", "<leader>f.", ":Telescope resume<CR>", { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>fM", ":Telescope man_pages<CR>", { desc = "Man pages" })
vim.keymap.set("n", "<leader>fo", ":Telescope aerial<CR>", { desc = "Find outline symbols" })
vim.keymap.set("n", "<leader>fc", function()
  require("telescope.builtin").colorscheme({ enable_preview = true })
end, { desc = "Colorschemes (live preview)" })

-- ============================================================================
-- Git (Fugitive)
-- ============================================================================
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gD", ":Glcd<CR>", { desc = "Git lcd (cd to repo root)" })

-- ============================================================================
-- UI / Utils
-- ============================================================================
vim.keymap.set("n", "<leader>uc", ":Themery<CR>", { desc = "Colorscheme picker" })
vim.keymap.set("n", "<leader>ux", "<cmd>HexToggle<CR>", { desc = "Toggle hex view" })

-- ============================================================================
-- Code (lint/format)
-- ============================================================================
-- <leader>cf (format) defined in lint-format.lua
-- <leader>cl (lint) defined in lint-format.lua
vim.keymap.set("n", "<leader>cj", "<cmd>FormatJSON<CR>", { desc = "Format buffer as JSON" })

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
-- Yank current file:line to clipboard
vim.keymap.set("n", "<leader>yf", ":let @+ = expand('%') . ':' . line('.')<CR>", { desc = "Yank file:line to clipboard" })

-- Prepend todo checkbox to current line
vim.keymap.set("n", "tt", function()
  vim.cmd("normal! ^I- [ ] ")
end, { desc = "Prepend todo checkbox" })

-- ============================================================================
-- Spell (markdown-specific)
-- ============================================================================
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    local bopts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set("n", "<leader>ze", ":set spell spelllang=en_us<CR>", vim.tbl_extend("force", bopts, { desc = "Spell enable" }))
    vim.keymap.set("n", "<leader>zd", ":set nospell<CR>", vim.tbl_extend("force", bopts, { desc = "Spell disable" }))
    vim.keymap.set("n", "<leader>zn", "]s", vim.tbl_extend("force", bopts, { desc = "Next misspelling" }))
    vim.keymap.set("n", "<leader>zp", "[s", vim.tbl_extend("force", bopts, { desc = "Prev misspelling" }))
    vim.keymap.set("n", "<leader>zf", "z=", vim.tbl_extend("force", bopts, { desc = "Fix spelling" }))
    vim.keymap.set("n", "<leader>za", "zg", vim.tbl_extend("force", bopts, { desc = "Add to dictionary" }))
    -- Wiki navigation
    vim.keymap.set("n", "<Backspace>", ":lua require('kiwi').open_wiki_index()<CR>", vim.tbl_extend("force", bopts, { desc = "Wiki index" }))
  end,
})

-- ============================================================================
-- Layouts
-- ============================================================================

-- Code Editor layout: wiki tab + terminal tab + 3 editor tabs
vim.keymap.set("n", "<leader>LE", function()
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
vim.keymap.set("n", "<leader>LW", function()
  for _ = 1, 3 do
    vim.cmd("tabnew")
    vim.cmd("set nonumber norelativenumber")
    vim.cmd("Neotree toggle")
    vim.cmd("wincmd l")
  end
  vim.cmd("tabnext 2")
end, { desc = "Writing layout" })

-- New editor tab with Neotree
vim.keymap.set("n", "<leader>LT", function()
  vim.cmd("tabnew")
  vim.cmd("Neotree toggle")
  vim.cmd("wincmd l")
end, { desc = "New editor tab" })

-- ============================================================================
-- Visual mode
-- ============================================================================
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
