-- vim plug is best plug
vim.api.nvim_command([[
    call plug#begin('~/.local/share/nvim/plugged')
        Plug 'williamboman/mason.nvim'
        Plug 'neovim/nvim-lspconfig'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'itchyny/lightline.vim'
        Plug 'bfrg/vim-cpp-modern'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'nvim-tree/nvim-web-devicons'
        Plug 'nvimdev/dashboard-nvim'
        Plug 'romgrk/barbar.nvim'
        Plug 'kana/vim-smartword'
        Plug 'catppuccin/nvim'
        Plug 'neanias/everforest-nvim'
        Plug 'rebelot/kanagawa.nvim'
        Plug 'rmehri01/onenord.nvim'
        Plug 'rose-pine/neovim'
    call plug#end()
]])

require("lsp")
require("colors")
require("startup-screen")

vim.cmd.source(vim.fn.stdpath("config") .. "/compat.vim")
