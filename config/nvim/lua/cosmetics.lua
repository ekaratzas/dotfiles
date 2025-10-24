require("colorschemes.catppuccin")
require("colorschemes.everforest")
require("colorschemes.kanagawa")
require("colorschemes.onenord")
require("colorschemes.rose-pine")

--vim.o.background = dark
-- get colorscheme override from environmental variable
local colorscheme = os.getenv("COLORSCHEME")
if not colorscheme or colorscheme == "" then
    colorscheme = "catppuccin"
end
vim.cmd("colorscheme " .. colorscheme)

vim.g.lightline = {
    colorscheme = 'catppuccin'
}

-- cheers to JackDerksen/viis-lazyvim
function SetRandomLineNrColor()
  math.randomseed(os.time())

  local colors = {
    "#b4befe", -- Lavender
    "#eba0ac", -- Maroon
    "#d2fac5", -- Green
    "#f2cdcd", -- Flamingo
    "#cba6f7", -- Mauve
    "#fcc6a7", -- Peach
    "#89b4fa", -- Blue
    "#89dceb", -- Sky
  }

  local index = math.random(#colors)
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors[index], bold = true })
end

-- Ensure the random color is selected each time Neovim starts
vim.cmd("autocmd VimEnter * lua SetRandomLineNrColor()")

-- Setting highlights for lines above and below
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#6e738d", bold = false })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#6e738d", bold = false })

require'barbar'.setup({
    animation = false,
    icons = {
        buffer_number = true,
    },
})

-- show class/function name context at top
vim.g.context_highlight_border = '<hide>'
vim.g.context_enable = 1
