-- vim plug is best plug
vim.api.nvim_command([[
    call plug#begin('~/.local/share/nvim/plugged')
        Plug 'williamboman/mason.nvim'
        Plug 'neovim/nvim-lspconfig'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'gfanto/fzf-lsp.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'itchyny/lightline.vim'
        Plug 'bfrg/vim-cpp-modern'
        Plug 'wellle/context.vim'
        Plug 'nvim-tree/nvim-web-devicons'
        Plug 'nvimdev/dashboard-nvim'
        Plug 'romgrk/barbar.nvim'
        Plug 'kana/vim-smartword'
        Plug 'folke/persistence.nvim'
        Plug 'catppuccin/nvim'
        Plug 'neanias/everforest-nvim'
        Plug 'rebelot/kanagawa.nvim'
        Plug 'rose-pine/neovim'
        Plug 'morhetz/gruvbox'
    call plug#end()
]])

require("lsp")
require("cosmetics")
require("startup-screen")

vim.cmd.source(vim.fn.stdpath("config") .. "/compat.vim")
