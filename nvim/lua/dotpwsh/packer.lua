-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  -- packer can manage itself
  use 'wbthomason/packer.nvim'

  -- themes
  use 'folke/tokyonight.nvim'

  -- lsp
  use 'neovim/nvim-lspconfig'
  use "lukas-reineke/lsp-format.nvim"
  use "onsails/lspkind.nvim"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'SirVer/ultisnips'
  use 'quangnguyen30192/cmp-nvim-ultisnips'

  -- fzf
  use {'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
  use 'junegunn/fzf.vim'

  -- telescope
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'MichaHoffmann/tree-sitter-hcl'

  -- other
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }
}

end)
