-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {

  ------------------------------------------------------------
  -- https://github.com/rockerBOO/awesome-neovim#markdown-and-latex
  -- MARKDOWN

  -- https://github.com/jdhao/nvim-config

  -- Another markdown plugin
  {
    'preservim/vim-markdown',
    ft = { 'markdown' },
    config = function()
      require 'custom.config.v_vim-markdown'
    end,
  },

  -- Vim tabular plugin for manipulate tabular, required by markdown plugins
  { 'godlygeek/tabular', cmd = { 'Tabularize' } },
  -- config = [[require('plugins.v_tabular')]] }

  -- Please make sure that you have installed node.js .
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
    config = function()
      require 'custom.config.v_markdown-preview'
    end,
  },

  ------------------------------------------------------------
}
