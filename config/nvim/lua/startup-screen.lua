require("persistence").setup()

require("dashboard").setup({
    theme = "hyper",
    config = {
    --    disable_move = true,
        header = require("asciiart"),
        footer = {
            "",
            "Fortis Fortuna Adiuvat",
        },
        packages = { enable = false },
        project = { enable = false },
        shortcut = {
            { desc = 'gpf @ ' .. vim.fn.hostname(), group = 'DashboardShortCut' },
            {
                icon = ' ',
                desc = 'restore last session',
                group = 'DiagnosticHint',
                action = 'lua require("persistence").load({ last = true })',
                key = 'r',
            },
        },

    },
    hide = {
        statusline = true,
        tabline = true,
        winbar = true,
    },
})

-- execute dashboard if no more active buffers
-- Note: this seems to cause an exception in dashboard's hyper.lua when trying to open a file in read-only
-- mode because another instance of nvim already has it open.
-- Additionally, it seems to clash violently with barbar plugin, turning it off for now.
-- vim.cmd [[ au BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) && winnr('$') == 1 | exec 'Dashboard' | endif ]]
