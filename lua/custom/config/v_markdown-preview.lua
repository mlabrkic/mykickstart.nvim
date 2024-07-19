--[[
https://github.com/iamcco/markdown-preview.nvim
Vim Script
Markdown Preview for (Neo)vim

]]

vim.cmd( [[

"""""""""""""""""""""""""markdown-preview settings"""""""""""""""""""
" https://github.com/jdhao/nvim-config

" Only setting this for suitable platforms

" Do not close the preview tab when switching to other buffers
let g:mkdp_auto_close = 0

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
" let g:mkdp_browser = ''
let g:mkdp_browser = 'chrome'

" Shortcuts to start and stop markdown previewing
nnoremap <silent> <M-m> :<C-U>MarkdownPreview<CR>
nnoremap <silent> <M-S-m> :<C-U>MarkdownPreviewStop<CR>

]] )

