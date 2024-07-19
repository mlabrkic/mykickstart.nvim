-- after/ftplugin/java.lua
--[[
https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#configuration-verbose
Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls

:lua print(vim.env.USERPROFILE)

]]
local root_files = { 'pom.xml' }

-- local paths = vim.fs.find('pom.xml', {
local paths = vim.fs.find(root_files, {
  upward = true,
  stop = 'C:\\MB_DEV',
})

print(vim.fs.dirname(paths[1]))
-- C:\MB_DEV\00JAVA\WinappdriverCalculator

local root_dir = vim.fs.dirname(paths[1])

------------------------------------------------------------
--[[
http://download.eclipse.org/jdtls/milestones/

jdt-language-server-1.31.0-202401111522.tar.gz

==> "Unzip", Rename to jdtls
Copy to
C:\UTILS\NvimLSP_man\packages\

C:\UTILS\NvimLSP_man\packages\jdtls\plugins\org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar
C:\UTILS\NvimLSP_man\packages\jdtls\config_win\
C:\UTILS\NvimLSP_man\packages\jdtls\lombok.jar
]]
------------------------------------------------------------
-- EDIT:

-- local path_to_java = "java"
local path_to_java = vim.fn.getenv 'java_home' .. 'bin\\java' -- echo %java_home%

local install_root_dir = 'C:\\UTILS\\NvimLSP_man' -- manually install jdtls

-- Data directory - change it to your liking
local WORKSPACE_PATH = install_root_dir .. '\\workspace\\java\\'

------------------------------------------------------------
-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- :h filename-modifiers
local path_to_workspace_dir = WORKSPACE_PATH .. project_name

------------------------------------------------------------
local jdtls_path = install_root_dir .. '\\packages\\jdtls'

local path_to_launcher_jar = vim.fn.glob(jdtls_path .. '\\plugins\\org.eclipse.equinox.launcher_*.jar')
local path_to_os_config = jdtls_path .. '\\config_win'
local path_to_lombok_jar = jdtls_path .. '\\lombok.jar'

------------------------------------------------------------
-- https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#configuration-verbose
-- Watch out for the 💀, it indicates that you must adjust something.

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    path_to_java, -- 💀
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. path_to_lombok_jar,
    '-Xms1g', -- initial memory allocation pool
    -- '-Xmx1g', -- typically has a default value of 256 MB
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    path_to_launcher_jar, -- 💀
    '-configuration',
    path_to_os_config, -- 💀
    '-data',
    path_to_workspace_dir, -- 💀
  },
  root_dir = root_dir, -- 💀

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {},
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

------------------------------------------------------------
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function() -- mlabrkic
    vim.cmd [[
      nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
      nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
      vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
      nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
      vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
      vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>
    ]]
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function() -- mlabrkic
    -- local bufmap = function(mode, lhs, rhs)
    --   local opts = {buffer = event.buf}
    --   vim.keymap.set(mode, lhs, rhs, opts)
    -- end

    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = 0, desc = desc }) -- mlabrkic: 0` or `true` for current buffer
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    --   vim.lsp.buf.format()
    -- end, { desc = 'Format current buffer with LSP' })
  end,
})
