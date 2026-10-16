require("misc")
require("options")
require("remap")
require("lazy_setup")

vim.cmd.colorscheme("custom")
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" }) -- opacity
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
