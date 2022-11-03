-- vim.g.UltiSnipsExpandTrigger = "<F12>"
-- vim.g.UltiSnipsJumpForwardTrigger = "<F12>"
-- vim.g.UltiSnipsJumpBackwardTrigger = "<F12>"
vim.g.UltiSnipsSnippetDirectories = {'UltiSnips'}

vim.opt.rtp:append('/usr/local/bin/fzf')

local cmp = require('cmp')
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local lspkind = require("lspkind")

cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ["<Tab>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
      ),
      ["<S-Tab>"] = cmp.mapping(
        function(fallback)
          cmp_ultisnips_mappings.jump_backwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
      ),
    }),

    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',

            before = function (entry, vim_item)
                return vim_item
            end
        })
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },

      { name = 'ultisnips' }, -- For ultisnips users.

    }, {
      { name = 'buffer' },
    })
})
