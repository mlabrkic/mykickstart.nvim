-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {

  ------------------------------------------------------------
  -- h bufferline, TAB
  {
    'akinsho/bufferline.nvim',
    event = 'BufReadPre',
    -- :help bufferline-settings
    opts = {

      options = {
        mode = 'buffers',
        numbers = 'buffer_id',
        offsets = {
          { filetype = 'NvimTree' },
        },
        -- color_icons = true, -- whether or not to add the filetype icon highlights
      },
      -- :help bufferline-highlights
      highlights = {
        buffer_selected = {
          italic = false,
        },
        indicator_selected = {
          fg = { attribute = 'fg', highlight = 'Function' },
          italic = false,
        },
      },
    },
  },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    -- opts = {
    --   modes = {
    --     char = {
    --       enabled = false, -- mlabrkic: require("flash").jump() ==> try "f"
    --       -- jump_labels = true,
    --     },
    --   },
    -- },
    -- stylua: ignore
    keys = {
      -- { "f", mode = { "n" }, function() require("flash").jump() end, desc = "Flash" }, -- mlabrkic
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    -- opts = {},
    config = function()
      require('marks').setup {}
    end,
  },

  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
          natural_order = true,
          is_always_hidden = function(name, _)
            return name == '..' or name == '.git'
          end,
        },
        win_options = {
          wrap = true,
        },
      }
    end,
  },

  ------------------------------------------------------------
  -- date: 2024-01M-15 13:29:25
  -- Java JDT.LS
  { 'mfussenegger/nvim-jdtls', ft = { 'java' } },

  ------------------------------------------------------------
}
