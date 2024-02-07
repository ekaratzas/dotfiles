vim.api.nvim_command([[
    call plug#begin('~/.local/share/nvim/plugged')
        Plug 'williamboman/mason.nvim'
        Plug 'neovim/nvim-lspconfig'
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
        Plug 'itchyny/lightline.vim'
        Plug 'bfrg/vim-cpp-modern'
    call plug#end()
]])

require("lsp")

-- annoying diagnostics are annoying
vim.diagnostic.disable()

vim.cmd('source ~/.config/nvim/compat.vim')
