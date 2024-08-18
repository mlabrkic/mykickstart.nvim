if vim.g.neovide then
  require('custom.gui.neovide').setup() -- 3. now i use this (Windows 10)
  vim.print('Neovide version:' .. vim.g.neovide_version)
  -- :echo exists('g:neovide')
  -- print 'we got neovide'
elseif vim.g.goneovim then
  -- require('custom.gui.goneovim').setup() -- 2.
  -- print 'we got goneovim'
elseif vim.g.GuiLoaded then
  -- require('custom.gui.nvimqt').setup() -- 1.
  -- print 'we got nvimqt'
end
