-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader keys (set before lazy setup)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Load modern Lua configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Load legacy vim config for remaining settings
vim.cmd('source ~/.config/nvim/legacy.vim')

-- Setup lazy.nvim with modern plugins
require("lazy").setup({
  -- Modern essentials
  { 
    "folke/which-key.nvim", 
    event = "VeryLazy",
    config = function()
      require("which-key").setup({})
    end
  },
  
  -- Telescope (already configured in legacy.vim)
  { 
    "nvim-telescope/telescope.nvim", 
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons"
    },
    -- Config is already in legacy.vim
  },
  
  -- LSP Support (modern replacement for old completion)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { 
          "lua_ls", 
          "tsserver", 
          "html", 
          "cssls",
          "jsonls",
          "bashls"
        },
        automatic_installation = true,
      })
      
      -- Basic LSP configuration
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      -- Setup language servers
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.tsserver.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
    end
  },
  
  -- Autocompletion (modern replacement for YCM)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })
      
      -- Command line completion
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'path' },
          { name = 'cmdline' }
        }
      })
    end
  },
  
  -- Git integration (modern replacement for git plugins)
  { 
    "lewis6991/gitsigns.nvim", 
    config = function()
      require('gitsigns').setup({
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        }
      })
    end
  },
  
  -- File explorer (modern replacement for NERDTree)
  { 
    "nvim-tree/nvim-tree.lua", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          highlight_git = true,
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
              folder_arrow = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          custom = { ".DS_Store" },
        },
      })
      
      -- Key mappings
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { silent = true })
      vim.keymap.set('n', '<F10>', ':NvimTreeToggle<CR>', { silent = true })
    end
  },
  
  -- Status line (modern replacement for lightline)
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
      })
    end
  },
  
  -- Syntax highlighting (modern replacement for various syntax plugins)
  { 
    "nvim-treesitter/nvim-treesitter", 
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "javascript", "typescript", "python", "bash", 
          "html", "css", "json", "markdown", "php", "scss"
        },
        auto_install = true,
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end
  },
  
  -- Your existing colorscheme
  { "vim-scripts/BusyBee" },
  
  -- Modern commenting (replacement for nerdcommenter)
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end
  },
  
  -- Modern diagnostics (replacement for syntastic)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true })
      vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true })
    end
  },
  
  -- Modern fuzzy finder (replacement for ctrlp)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('fzf-lua').setup({
        'telescope',
        winopts = {
          height = 0.85,
          width = 0.80,
        }
      })
      -- Keep existing telescope keybindings but add fzf alternatives
      vim.keymap.set('n', '<leader>F', '<cmd>FzfLua files<cr>', { silent = true })
      vim.keymap.set('n', '<leader>G', '<cmd>FzfLua live_grep<cr>', { silent = true })
    end
  },
  
  -- Markdown preview (keep existing)
  { 
    'iamcco/markdown-preview.nvim', 
    build = 'cd app && npx --yes yarn install',
    ft = 'markdown'
  },
  
  -- Color preview (keep existing)
  { 
    'rrethy/vim-hexokinase', 
    build = 'make hexokinase',
    config = function()
      vim.g.Hexokinase_highlighters = {'backgroundfull'}
    end
  },
  
  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
      -- Integration with cmp
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
})

-- Additional LSP keybindings
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
  end,
})

-- Modern clipboard setup (replacement for legacy clipboard config)
if vim.fn.has('clipboard') == 1 then
  if vim.fn.has('unnamedplus') == 1 then
    vim.opt.clipboard = 'unnamed,unnamedplus'
  else
    vim.opt.clipboard = 'unnamed'
  end
end