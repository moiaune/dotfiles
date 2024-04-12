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
]]

-- load bash profile in neovim terminal
vim.o.shell = "/usr/local/bin/bash -l"

vim.opt.encoding = 'utf-8'
vim.o.termguicolors = true
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

-- enabled mouse support
vim.opt.mouse = 'a'

-- ???
vim.opt.completeopt = "menu,menuone,noselect"

-- show whitespaces characters
vim.opt.listchars = { eol = "↲", tab = "> ", trail = "~", precedes = "<", space = " ", nbsp = "×" }
vim.opt.list = true

-- disable unused modules
vim.g.loaded_perl_provider = 0

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
    use 'sainnhe/everforest'
    use 'arcticicestudio/nord-vim'
    use 'jeffkreeftmeijer/vim-dim'
    use 'sainnhe/edge'
    use 'folke/tokyonight.nvim'
    use "EdenEast/nightfox.nvim"
    use "olimorris/onedarkpro.nvim"
    use "ellisonleao/gruvbox.nvim"

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use "rafamadriz/friendly-snippets"

    -- language specifics
    use 'carlsmedstad/vim-bicep'

    -- telescope
    use 'nvim-lua/plenary.nvim'
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use 'nvim-telescope/telescope.nvim'

    -- formatter for Powershell
    use 'JayDoubleu/vim-pwsh-formatter'

    -- fzf
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'williamboman/mason.nvim'

    -- markdown
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" },
    })

    -- other
    use 'airblade/vim-gitgutter'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'folke/todo-comments.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'akinsho/toggleterm.nvim'
end)

-- -----------------------------
-- ---      TELESCOPE        ---
-- -----------------------------

require('telescope').setup({
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.95,
        },
    },
    pickers = {
        find_files = {
            disable_devicons = true
        },
        live_grep = {
            disable_devicons = true
        },
        buffers = {
            disable_devicons = true
        },
        help_tags = {
            disable_devicons = true
        },
        diagnostics = {
            disable_devicons = true
        },
        git_commits = {
            disable_devicons = true
        },
    },
})

-- -----------------------------
-- ---    VIM-COMMENTARY     ---
-- -----------------------------
vim.cmd [[
    autocmd FileType terraform setlocal commentstring=#\ %s
]]

-- -----------------------------
-- ---      TREESITTER       ---
-- -----------------------------

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "lua",
        "terraform",
        "go",
        "javascript",
        "html",
        "css",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    }
})


-- -----------------------------
-- ---      LUALINE       ---
-- -----------------------------

require('lualine').setup({
    options = {
        theme = 'auto',
        -- theme = {
        --     normal = {
        --         a = { fg = "black", bg = "yellow" },
        --         b = { fg = "yellow", bg = "black" },
        --         c = { fg = "white", bg = "black" },
        --         x = { fg = "white", bg = "black" },
        --         y = { fg = "white", bg = "black" },
        --         z = { fg = "white", bg = "black" },
        --     },
        -- },
        icons_enabled = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1, } },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "location", "progress" },
        lualine_z = { {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic", "nvim_lsp" },
            sections = { "error", "warn" },
            diagnostics_color = {
                -- Same values as the general color option can be used here.
                error = 'red',    -- Changes diagnostics' error color.
                warn  = 'orange', -- Changes diagnostics' warn color.
            },
            symbols = { error = "E", warn = "W" },
            colored = true,
            update_in_insert = false,
            always_visible = true,
        } },
    }
})

-- -----------------------------
-- ---    TODO-COMMENTS      ---
-- -----------------------------

require("todo-comments").setup({
    signs = false,
    gui_style = {
        fg = "ITALIC",
    },
    merge_keywords = false,
    highlight = {
        multiline = true,
        before = "fg",
        keyword = "bg",
        after = "fg",
        comments_only = true,
    },
})

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
-- ---        LUASNIP        ---
-- -----------------------------
-- load snippets from path/of/your/nvim/config/snippets
require("luasnip.loaders.from_vscode").load({ paths = { "./snippets" } })

-- -----------------------------
-- ---   AUTOCOMPLETE (CMP)  ---
-- -----------------------------
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
    },
    mapping = {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm()
            else
                fallback()
            end
        end, { "i", "s" })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip', option = { show_autosnippets = true } }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- -----------------------------
-- ---         LSP           ---
-- -----------------------------

local capabilities = vim.tbl_deep_extend(
    "force",
    require("lspconfig").util.default_config.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

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
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, bufopts)

    vim.cmd([[
        augroup formatting
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        augroup END
    ]])
end

require("lspconfig")["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    'vim',
                }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    }
})

require("lspconfig")["gopls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            gofumpt = true,
        }
    }
})

require("lspconfig")["terraformls"].setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
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
        vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, bufopts)
        vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, bufopts)
    end
})

require('lspconfig')['powershell_es'].setup({
    bundle_path = '/Users/mm/.config/PowerShellEditorServices',
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["powershell"] = {
            codeFolding = {
                enable = false,
            },
            codeFormatting = {
                newLineAfterCloseBrace = false,
                pipelineIndentationStyle = "IncreaseIndentationForFirstPipeline",
                trimWhitespaceAroundPipe = true,
                useCorrectCasing = true,
                whitespaceBetweenParameters = true,
                openBraceOnSameLine = true,
                alignPropertyValuePairs = true,
                ignoreOneLineBlock = true,
            }
        }
    }
})

local lsputil = require('lspconfig/util')
require('lspconfig')['bicep'].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "dotnet", "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll" },
    filetypes = { "bicep" },
    root_dir = lsputil.root_pattern(".git"),
})

require("lspconfig")["tsserver"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig")["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig")["cssls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

require("lspconfig")["jsonls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- -----------------------------
-- ---      TOGGLETERM       ---
-- -----------------------------

require('toggleterm').setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    direction = 'horizontal',
    close_on_exit = false,
})

-- keybindings
-- sends the whole line where you are standing with your cursor
local trim_spaces = true

vim.keymap.set("v", "<space>s", function()
    require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
end)

-- Replace with these for the other two options
-- require("toggleterm").send_lines_to_terminal("visual_line", trim_spaces, { args = vim.v.count })
-- require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

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
local ts_builtin = require('telescope.builtin')
vim.keymap.set("n", "<C-f>", ts_builtin.find_files)
vim.keymap.set("n", "<leader>ff", function() ts_builtin.find_files({ no_ignore = true, hidden = true }) end)
vim.keymap.set("n", "<leader>fg", ts_builtin.live_grep)
vim.keymap.set("n", "<leader>b", ts_builtin.buffers)
vim.keymap.set("n", "<leader>fh", ts_builtin.help_tags)
vim.keymap.set("n", "<leader>fd", ts_builtin.diagnostics)
vim.keymap.set("n", "<leader>gc", ts_builtin.git_commits)
vim.keymap.set("n", "<leader>qf", ts_builtin.quickfix)
vim.keymap.set("n", "<leader>gs", ts_builtin.git_status)

-- todo-comments
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope keywords=TODO,FIXME<cr>")

-- -----------------------------
-- ---     THEME SETTINGS    ---
-- -----------------------------

require('nightfox').setup({
    options = {
        styles = {
            comments = "italic",
        },
    },
})

vim.opt.background = 'dark'
-- vim.opt.background = 'light'
-- vim.g.everforest_background = 'hard'
-- vim.g.everforest_transparent_background = 1
-- vim.g.everforest_diagnostic_virtual_text = 'colored'
-- vim.g.everforest_enable_italic = 1
-- vim.g.everforest_diagnostic_text_highlight = 0
-- vim.g.everforest_diagnostic_line_highlight = 0
-- vim.g.everforest_better_performance = 1

vim.cmd [[
    colorscheme gruvbox
]]

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
-- vim.cmd("command! Pwshf PWSHFORMAT")
