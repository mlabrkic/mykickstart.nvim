-- https://github.com/dtr2300/nvim/blob/main/lua/config/gui/nvimqt.lua

-- https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/
-- GUI settings - ginit.vim

------------------------------------------------------------
--[[
nvim\after\plugin\options.lua
-- GUI:

--[[ neovim-qt wiki
https://github.com/equalsraf/neovim-qt/wiki#guifontguiforegroundetc-dont-exist

GuiFont/GuiForeground()/etc don't exist
:Gui, TAB

echo exists('g:GuiLoaded')
or
lua print(vim.g.GuiLoaded)
==> 0

Likely means the neovim-gui-shim plugin is not being loaded,
check your &runtimepath it should include a nvim-qt folder in there.
echo &rtp

nvim_gui_shim.vim :
C:\UTILS\PORT\Neovim\share\nvim-qt\runtime\plugin\nvim_gui_shim.vim

set &rtp to include the runtime folder
h rtp
vim.opt.rtp:append("C:/UTILS/PORT/Neovim/share/nvim-qt/runtime/")  -- mlabrkic

------------------------------
:lua print(vim.opt.rtp)

:lua rtp1 = vim.opt.rtp
:lua =rtp1

:QRedir lua =rtp1

------------------------------
h vim.cmd

h vim.fn
Invokes |vim-function| or |user-function|
]]
------------------------------------------------------------

local M = {}

-- Default options {opts}: {remap = false, silent = false, expr = false}

local keymap = function( mode, key, result, desc )
  vim.keymap.set( mode, key, result, { desc = desc, silent = true, } )
end

-- local fontname = "FiraCode NF"
local fontname = "SauceCodePro NF"
local fontsize_default = 16
local fontsize = fontsize_default
local isfullscreen = false

---@param size? number
local function set_fontsize(size)
  fontsize = size or fontsize_default
  vim.cmd.GuiFont { fontname .. ":h" .. fontsize, bang = true }
end

---@param amount number
local function adjust_fontsize(amount)
  set_fontsize(fontsize + amount)
end

local function fullscreen_toggle()
  isfullscreen = not isfullscreen
  vim.fn.GuiWindowFullScreen(isfullscreen and 1 or 0)
end

function M.setup()
  vim.cmd.GuiTabline = 0
  vim.cmd.GuiPopupmenu = 0
  vim.cmd.GuiLinespace = 2  -- jdhao

  set_fontsize()

  keymap( "n", "<leader>+", function() adjust_fontsize(1) end, "Adjust fontsize +1" )
  keymap( "n", "<leader>-", function() adjust_fontsize(-1) end, "Adjust fontsize -1" )
  keymap( "n", "<leader>0", function() set_fontsize() end, "Reset fontsize" )

  keymap( "n", "<C-F11>", fullscreen_toggle, "Toggle fullscreen" )
end

return M
