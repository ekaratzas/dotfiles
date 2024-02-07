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
            { desc = '-- gpf @ ' .. vim.fn.hostname() .. ' --', group = 'DashboardShortCut' },
        },

    },
    hide = {
        statusline = true,
        tabline = true,
        winbar = true,
    },
})
