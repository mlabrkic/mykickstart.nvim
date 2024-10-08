-- https://github.com/dtr2300/nvim/blob/main/lua/config/gui/nvimqt.lua
-- GUI settings - ginit.vim

------------------------------------------------------------
-- https://github.com/akiyosi/goneovim/wiki/Tips
-- goneovim ne prepoznaje ginit.vim !?
-- ==>
-- C:\Users\...\nvim\after\plugin\autocmds.lua
-- require("custom.gui.goneovim").setup()

------------------------------------------------------------
--[[

echo exists('g:goneovim')
==> 1
or
lua print(vim.g.goneovim)
==> true

------------------------------
vim.opt.guifont

lua print(vim.opt.guifont)
lua print(vim.inspect(vim.opt.guifont))

------------------------------
:lua print(vim.opt.rtp)

:lua rtp1 = vim.opt.rtp
:lua =rtp1

:QRedir lua =rtp1

------------------------------
h vim.cmd
h vim.fn

]]
------------------------------------------------------------

local M = {}

-- Default options {opts}: {remap = false, silent = false, expr = false}

local keymap = function(mode, key, result, desc)
  vim.keymap.set(mode, key, result, { desc = desc, silent = true })
end

-- :set guifont=*
-- ==> SauceCodePro NF
-- :set guifont=SauceCodePro_NF:h20
--
-- Font can contain spaces by either escaping them or using _ (underscores)
-- local fontname = 'SauceCodePro\\ NF'
local fontname = 'SauceCodePro_NF'

local fontsize_default = 16
local fontsize = fontsize_default

---@param size? number
local function set_fontsize(size)
  fontsize = size or fontsize_default
  vim.opt.guifont = fontname .. ':h' .. fontsize
  -- local setcmd = 'set guifont=' .. fontname .. ':h' .. fontsize
  -- vim.cmd(setcmd)
end

---@param amount number
local function adjust_fontsize(amount)
  set_fontsize(fontsize + amount)
end

function M.setup()
  set_fontsize()

  keymap('n', '<C-+>', function()
    adjust_fontsize(1)
  end, 'Adjust fontsize +1')
  keymap('n', '<C-->', function()
    adjust_fontsize(-1)
  end, 'Adjust fontsize -1')
  keymap('n', '<C-0>', function()
    set_fontsize()
  end, 'Reset fontsize')
end

vim.cmd [[ normal! zz ]]

return M
