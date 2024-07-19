--[[
https://github.com/preservim/vim-markdown
Vim Script
Syntax highlighting, matching rules and mappings for the original Markdown and extensions.

]]

vim.cmd( [[

"""""""""""""""""""""""""vim-markdown settings"""""""""""""""""""
" https://github.com/jdhao/nvim-config

" Disable header folding
let g:vim_markdown_folding_disabled = 1

" Whether to use conceal feature in markdown
" h concealcursor
" h conceallevel
let g:vim_markdown_conceal = 1

" Disable math tex conceal and syntax highlight
let g:tex_conceal = ''
let g:vim_markdown_math = 0

" Support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

" Let the TOC window autofit so that it doesn't take too much space
let g:vim_markdown_toc_autofit = 1

" ------------------------------
" https://github.com/preservim/vim-markdown#fenced-code-block-languages
" Default is ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini'].
let g:vim_markdown_fenced_languages = ['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'lua=lua']

" ```lua
"
" ```

" https://github.com/preservim/vim-markdown#do-not-require-md-extensions-for-markdown-links
" This is super useful for GitLab and GitHub wiki repositories.
let g:vim_markdown_no_extensions_in_markdown = 1

" gx: open the link under the cursor in the same browser as the standard gx command.
" ge: open the link under the cursor in Vim for editing. Useful for relative markdown links.

]] )

-- vim.keymap.set('n', 'š', '<Plug>Markdown_MoveToPreviousHeader')
vim.keymap.set('n', 'šš', '<Plug>Markdown_MoveToPreviousHeader')

-- vim.keymap.set('n', 'đ', '<Plug>Markdown_MoveToNextHeader')
vim.keymap.set('n', 'đđ', '<Plug>Markdown_MoveToNextHeader')


