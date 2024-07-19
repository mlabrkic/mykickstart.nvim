if vim.g.GuiLoaded == 1 then
  -- require('custom.gui.nvimqt').setup()
  -- print 'we got nvimqt'
elseif vim.g.goneovim == 1 then
  require('custom.gui.goneovim').setup() -- now i use this (Windows 10)
  -- print 'we got goneovim'
end
