-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', ',h', '<C-w>h', opts)
vim.keymap.set('n', ',j', '<C-w>j', opts)
vim.keymap.set('n', ',k', '<C-w>k', opts)
vim.keymap.set('n', ',l', '<C-w>l', opts)
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

--- Mine
vim.keymap.set('n', '<leader><Space>', '@q', { desc = 'Run macro q' })
vim.keymap.set('n', '<leader>T', function()
    vim.cmd('tabnew')
    vim.cmd('Neotree toggle')
    vim.cmd('wincmd l')
end, {desc = "editor tab" })
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', opts)
vim.keymap.set('n', '<C-w>', ':tabprev<CR>', opts)
vim.keymap.set('n', '<C-e>', ':tabnext<CR>', opts)
vim.keymap.set('n', '<C-n>', ':Neotree reveal<CR>', opts)
vim.keymap.set('n', '<C-g>', ':AerialToggle right<CR>', opts)
vim.keymap.set('n', '<C-b>', ':botright 25split term://bash<CR>', opts)
vim.keymap.set('n', '<C-p>', ':botright 25split term://python3<CR>', opts)
vim.keymap.set('n', '<C-a>', ':botright 25split term://cline<CR>', opts)
vim.keymap.set('n', 'bB', ':vsplit term://bash<CR>', opts)
vim.keymap.set('n', 'bP', ':vsplit term://python3<CR>', opts)
vim.keymap.set('n', 'vv', ':vsplit<CR>', opts)
vim.keymap.set('n', 'ss', ':split<CR>', opts)
vim.keymap.set('n', '<leader>gs', ':Git<CR>', opts)
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>', opts)
vim.keymap.set('n', '<leader>gp', ':Git pull<CR>', opts)
vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', opts)
vim.keymap.set('n', '<leader>c', ':Themery<CR>', opts)

vim.keymap.set("n", "<Leader>W", ":let @+ = expand('%') . ':' . line('.')<CR>", { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff',':Telescope find_files<CR>', opts)
vim.keymap.set('n', '<leader>fb',':Telescope buffers<CR>', opts)
vim.keymap.set('n', '<leader>fg',':Telescope live_grep<CR>', opts)
vim.keymap.set('n', '<leader>ft',':Telescope lsp_document_symbols<CR>', opts)
vim.keymap.set('n', '<leader>sw', function()
  require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })
end, { desc = '[S]earch [W]ord under cursor' })
vim.api.nvim_set_keymap("n", "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", { noremap = true, silent = true })

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<leader><Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<leader><Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<leader><Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<leader><Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-----------------
--   Autocmd   --
-----------------
-- Auto save session. Using Shatur/neovim-session-manager. Disabled for now in favor of suave
--vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--  callback = function ()
--    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--      -- Don't save while there's any 'nofile' buffer open.
--      if vim.api.nvim_get_option_value("buftype", { buf = buf }) == 'nofile' then
--        return
--      end
--    end
--    session_manager.save_current_session()
--  end
--})

-- Shortcut window
local function create_floating_window()
    -- Create an unlisted and scratch buffer
    local buf = vim.api.nvim_create_buf(false, true)

    -- Populate the buffer with some text
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
      "C+b - Bash split",
      "C+p - Python split",
      "C+n - Neotree",
      "C+g - AerialToggle",
      "C+a - cline",
      "bB - bash vsplit",
      "bP - python vsplit",
      "",
      "\\du - Debugger toggle",
      "\\db - Set breakpoint",
      "\\dc - Continue",
      "",
      "\\ff - Find files",
      "\\ft - Find tags",
      "\\fb - Find buffers",
      "\\fg - Find grep",
      "\\sw - Search word",
      "\\xx - Toggle Trouble",
      "",
      "\\c - Colorscheme picker",
      "za - Fold here",
      "zR - remove all folds",
      "\\W - where am I",
      "",
      "\\ww - vimwiki",
      "C-Space - toggle todo",
      "C-O - goback vimwiki",
      "",
      "\\gd - goto definition",
      "\\gr - goto references",
      "",
      "\\gs - Git status",
      "\\gc - Git commit",
      "\\gp - Git pull",
    })

    -- Define the window configuration
    local opts = {
        relative = "editor", -- Position relative to the editor
        width = 50,
        height = 50,
        col = math.floor((vim.o.columns / 2) - (50 / 2)), -- Center horizontally
        row = math.floor((vim.o.lines / 2) - (5 / 2)),    -- Center vertically
        anchor = "NW",    -- Anchor point (North-West)
        style = "minimal", -- Minimal style (no borders)
        border = "rounded", -- Rounded borders
    }

    -- Open the floating window
    local win = vim.api.nvim_open_win(buf, true, opts)

    -- Set options for the window (e.g., transparency)
    vim.api.nvim_win_set_option(win, "winblend", 10)
end

-- You can then map a key to this function in your Neovim configuration (e.g., init.lua)
vim.keymap.set("n", "<leader>=", create_floating_window, { desc = "Open Floating Window" })

vim.keymap.set("n", "tt", function()
  vim.cmd("normal! ^I- [ ] ") -- Moves to the beginning of the line and enters Insert mode
end, { desc = "Prepend to current line" })
