-- -----------------------------
-- --- GLOBAL CONFIGURATIONS ---
-- -----------------------------

-- use space as <leader> key
vim.g.mapleader = " "

-- vim.opt.correct lang to make copy to clipboard utf-8
vim.cmd [[
    lang en_US.UTF-8
    syntax on
    filetype plugin indent on
    colorscheme monokai_pro
]]

vim.opt.encoding = 'utf-8'
vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.opt.regexpengine = 1

-- relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indent with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- hightlight active line
vim.opt.cursorline = true

-- searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

-- treat dash separated words as a word text-object
vim.opt.iskeyword:append('-')

-- integrate vim clipboard with system clipboard
vim.opt.clipboard:append('unnamedplus')

-- display title of current file in terminal title bar
vim.opt.title = true

-- allow hidden buffers
vim.opt.hidden = true

-- disable beeping
vim.opt.errorbells = false

-- dont wrap long lines
vim.opt.wrap = false

-- dont use swapfiles
vim.opt.swapfile = false

-- disable backups
vim.opt.backup = false
vim.opt.writebackup = false

-- start scrolling when 8 lines left
vim.opt.scrolloff = 8

-- always show the sign column
vim.opt.signcolumn = 'yes'

-- new splits are added to bottom or right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- avoid delays when typing
vim.opt.updatetime = 50

-- set py version
vim.opt.pyx = 3

-- display colorcolumn at 115 characters
vim.opt.colorcolumn = '115'

-- color column color
vim.cmd('highlight ColorColumn ctermbg=darkgray')

-- ???
vim.opt.completeopt = "menuone,noselect"

-- Make comments use italic
vim.api.nvim_set_hl(0, 'Comment', { cterm = { italic = true } })

-- -----------------------------
-- ---    PLUGINS (PACKER)   ---
-- -----------------------------

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
    -- packer can manage itself
    use 'wbthomason/packer.nvim'

    -- themes
    use 'tanvirtin/monokai.nvim'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-tree/nvim-web-devicons'
    use 'nvim-telescope/telescope.nvim'

    -- formatter for Powershell
    use 'JayDoubleu/vim-pwsh-formatter'

    -- fzf
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'williamboman/mason.nvim'

    -- other
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }

end)


-- -----------------------------
-- ---      TREESITTER       ---
-- -----------------------------

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "lua",
        "terraform",
        "go",
        "javascript",
        "html",
        "css"
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
}


-- -----------------------------
-- ---      LUALINE       ---
-- -----------------------------

require('lualine').setup {
    options = {
        theme = 'auto',
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "buffers" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            sections = { "error", "warn" },
            diagnostics_color = {
                -- Same values as the general color option can be used here.
                error = 'DiagnosticError', -- Changes diagnostics' error color.
                warn  = 'DiagnosticWarn', -- Changes diagnostics' warn color.
            },
            symbols = { error = "E", warn = "W" },
            colored = true,
            update_in_insert = false,
            always_visible = true,
        } },
    }
}

-- -----------------------------
-- ---    TODO-COMMENTS      ---
-- -----------------------------

require("todo-comments").setup {
    signs = false,
    keywords = {
        FIX = {
            color = "#fceda4",
            alt = { "FIXME", "FIXIT" },
        }
    },
    gui_style = {
        fg = "ITALIC",
        bg = "NONE",
    },
    merge_keywords = true,
    highlight = {
        before = "fg",
        keyword = "fg",
        after = "fg"
    }
}

-- -----------------------------
-- ---        MASON          ---
-- -----------------------------

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- -----------------------------
-- ---   AUTOCOMPLETE (CMP)  ---
-- -----------------------------
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<CR>'] = function(fallback)
      if cmp.visible() then
        cmp.confirm()
      else
        fallback()
      end
    end
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- -----------------------------
-- ---         LSP           ---
-- -----------------------------

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gd', "<cmd>Telescope lsp_definitions<CR>", bufopts)
    vim.keymap.set('n', 'gr', "<cmd>Telescope lsp_references<CR>", bufopts)
    vim.keymap.set('n', 'gi', "<cmd>Telescope lsp_implementations<CR>", bufopts)
    vim.keymap.set('n', '<space>D', "<cmd>Telescope lsp_type_definitions<CR>", bufopts)
    vim.keymap.set('n', '<space>d', "<cmd>Telescope diagnostics<CR>", bufopts)

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    vim.keymap.set('n', '<leader>dj', vim.diagnostics.goto_next, bufopts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostics.goto_prev, bufopts)

    vim.cmd([[
        augroup formatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        augroup END
    ]])

    -- Set autocommands conditional on server_capabilities
    vim.cmd([[
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]])
end

require("lspconfig")["sumneko_lua"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig")["gopls"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            gofumpt = true,
        }
    }
}

require("lspconfig")["golangci_lint_ls"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            gofumpt = true,
        },
    },
}

require("lspconfig")["terraformls"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['powershell_es'].setup {
    bundle_path = '/Users/mm/.config/PowerShellEditorServices',
    capabilities = capabilities,
    on_attach = on_attach,
}

require('lspconfig')['bicep'].setup {
    capabilities = capabilities,
    cmd = { "dotnet", "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll" },
    on_attach = on_attach,
}

require("lspconfig")["tsserver"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig")["html"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig")["cssls"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require("lspconfig")["jsonls"].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- -----------------------------
-- ---      KEYMAPPING       ---
-- -----------------------------

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<C-a>", "<C-o>", { noremap = false })

-- move visual line(s) up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move lines up/down
vim.keymap.set("n", "<S-Up>", "<cmd>m-2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>m+1<CR>")
vim.keymap.set("i", "<S-Up>", "<Esc><cmd>m-2<CR>")
vim.keymap.set("i", "<S-Down>", "<Esc><cmd>m+1<CR>")

-- keeps search in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- keeps half page up and down in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- deletes highlighted word/line into void and keeps the pasted value
-- in default register so you can paste many times
vim.keymap.set("x", "<leader>p", "\"_dP")

-- delete to void
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- search and replace
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- switching between windows
vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>")

-- resizing
vim.keymap.set("n", "<C-H><S-H>", "<cmd>vertical resize -4<CR>")
vim.keymap.set("n", "<C-L><S-L>", "<cmd>vertical resize +4<CR>")
vim.keymap.set("n", "<C-K><S-K>", "<cmd>resize +4<CR>")
vim.keymap.set("n", "<C-J><S-J>", "<cmd>resize -4<CR>")

-- telescope
vim.keymap.set("n", "<C-f>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>")
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")

-- todo-comments
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>")

-- -----------------------------
-- ---      COMMANDS       ---
-- -----------------------------

-- you might have to force true color when using regular vim inside tmux as the
-- colorscheme can appear to be grayscale with "termguicolors" option enabled.
vim.cmd [[
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
]]

-- reload file if changes from outside
vim.cmd("au FocusGained,BufEnter * :checktime")

-- avoid human error
vim.cmd("command! W w")

-- alias for powershell formatter
vim.cmd("command! Pwshf PWSHFORMAT")
