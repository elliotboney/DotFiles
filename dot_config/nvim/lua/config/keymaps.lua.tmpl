-- Modern Neovim keymaps
-- This extracts and modernizes keybindings from legacy config

local keymap = vim.keymap.set

-- Helper function for key options
local opts = { noremap = true, silent = true }

-- Control key bindings (from legacy config)
keymap('n', '<C-S>', ':update<CR>', opts)
keymap('n', '<C-A>', 'ggVG', opts)

-- Bash-like command line navigation
keymap('c', '<C-A>', '<Home>')
keymap('c', '<C-E>', '<End>')

-- Visual search and replace
keymap('v', '<C-r>', '"hy:%s/<C-r>h//gc<left><left><left>')

-- Folding with space
keymap('n', '<space>', 'za', opts)
keymap('v', '<space>', 'za', opts)

-- Natural movement with wrap
keymap('n', 'j', 'gj', opts)
keymap('n', 'k', 'gk', opts)
keymap('v', 'j', 'gj', opts)
keymap('v', 'k', 'gk', opts)

-- Faster viewport scrolling
keymap('n', '<C-e>', '3<C-e>', opts)
keymap('n', '<C-y>', '3<C-y>', opts)
keymap('v', '<C-e>', '3<C-e>', opts)
keymap('v', '<C-y>', '3<C-y>', opts)

-- Leader key commands
keymap('n', '<leader>v', ':e ~/.config/nvim/init.lua<CR>', opts)
keymap('n', '<leader>vv', ':e ~/.config/nvim/legacy.vim<CR>', opts)

-- Toggle search highlighting
keymap('n', '<leader>/', ':noh<CR>', opts)

-- Code folding levels
for i = 0, 9 do
  keymap('n', '<leader>f' .. i, ':set foldlevelstart=' .. i .. '<CR>', opts)
end

-- Fix Windows endlines
keymap('n', '<leader>fw', ':%s/\\r/<CR>', opts)

-- Remove trailing whitespace
keymap('n', '<F5>', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>', opts)

-- Switch between last two files
keymap('n', '<leader><leader>', '<c-^>', opts)

-- Easy buffer navigation
keymap('n', '<leader>bp', ':bprevious<cr>', opts)
keymap('n', '<leader>bn', ':bnext<cr>', opts)

-- Fix common typos
vim.cmd('cmap W w')
vim.cmd('cmap Q q')

-- Change indent continuously
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Alternative to leader
keymap('n', '\\', ',', opts)

-- Elevated write
vim.cmd('cmap w!! w !sudo tee % >/dev/null')

-- Add new line without entering insert mode
keymap('n', '<CR>', 'o<Esc>', opts)

-- Highlight search word under cursor without jumping
keymap('n', '<leader>h', '*<C-O>', opts)

-- Modern clipboard integration (macOS specific from legacy)
if vim.fn.has('mac') == 1 then
  keymap('v', '<C-c>', 'y:call system("pbcopy", getreg("\\\""))<CR>', opts)
  keymap('n', '<C-v>', ':call setreg("\\\"",system("pbpaste"))<CR>p', opts)
end

-- Format code (from legacy F7)
keymap('n', '<F7>', 'mzgg=G`z<CR>', opts)

-- Modern Telescope keybindings (keeping from legacy)
keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)

-- HTML tidy (from legacy config)
keymap('n', '<leader>x', ':%!tidy -q -i --show-errors 0 -w 100<CR>', opts)

-- Visual selection sourcing
keymap('n', '<leader>L', '^vg_y:execute @@<cr>', opts)