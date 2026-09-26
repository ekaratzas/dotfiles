-- :MasonInstall clangd
-- Note: c# required .net 8.0 sdk
-- :MasonInstall csharp-language-server
-- rust-analyzer comes from rustup, not mason
-- rustup component add rust-analyzer
require("mason").setup()

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach1 = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>S', '<cmd>lua vim.lsp.buf.workspace_symbol(vim.fn.input("Search for symbol: "))<CR>', opts)

  if vim.lsp.inlay_hint then
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>h',
        '<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })<CR>', opts)
  end
end

-- get builddir override from environmental variable
local builddir = os.getenv("BUILDDIR")
if not builddir or builddir == "" then
    builddir = "~/"
end

local nvim_version = vim.version()
if nvim_version.major == 0  and nvim_version.minor <= 9 then
    require'lspconfig'.clangd.setup {
        cmd = { 'clangd', '--background-index', '-j=4', '--clang-tidy=false' },
        on_attach = on_attach1,
        init_options = {
            compilationDatabasePath = builddir
        }
    }

    require'lspconfig'.csharp_ls.setup {
        on_attach = on_attach1,
        init_options = {
            AutomaticWorkspaceInit = true
        },
        root_dir = function(fname)
            return builddir
        end,
    }

    -- :-D
    vim.diagnostic.disable()
else
    vim.lsp.config.clangd = {
        cmd = { 'clangd', '--background-index', '-j=4', '--clang-tidy=false' },
        root_markers = { '.git', 'compile_commands.json' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        init_options = {
            compilationDatabasePath = builddir
        }
    }
    vim.lsp.enable('clangd')

    vim.lsp.config.rust_analyzer = {
        cmd = { 'rust-analyzer' },
        root_markers = { 'Cargo.toml', 'rust-project.json', '.git' },
        filetypes = { 'rust' },
        settings = {
            ['rust-analyzer'] = {
                check = { command = 'clippy' },
                cargo = { buildScripts = { enable = true } },
                procMacro = { enable = true },
            }
        }
    }
    vim.lsp.enable('rust_analyzer')

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                on_attach1(client, args.buf)
            end
        end,
    })
end
