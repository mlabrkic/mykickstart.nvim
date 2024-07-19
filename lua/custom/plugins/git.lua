-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {

  ------------------------------------------------------------
  -- GIT:
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    -- opts = {},
    config = function()
      require('diffview').setup {}
    end,
  },

  -- ]x — move to previous conflict
  -- [x — move to next conflict
  -- fancy visuals, and some mappings to handle conflict resolution
  -- { 'akinsho/git-conflict.nvim', event = 'VeryLazy', version = '*', config = true },

  -- Better git log display
  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = {
      'tpope/vim-fugitive',
    },
  },

  -- Better git commit experience
  -- { 'rhysd/committia.vim', lazy = true },

  ------------------------------------------------------------
}
