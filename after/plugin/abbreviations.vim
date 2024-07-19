" Abbreviations
" :h Abbreviations
" <space> --> expand abbreviation

" -----------------------------------------------------------------
" An abbreviation is only recognized when you type a non-keyword character.
" This can also be the <Esc> that ends insert mode or the <CR> that ends a
" command.  The non-keyword character which ends the abbreviation is inserted
" after the expanded abbreviation.  An exception to this is the character <C-]>,
" which is used to expand an abbreviation without inserting any extra
" characters.
" <C-]>

" -----------------------------------------------------------------
" https://vim.fandom.com/wiki/Using_abbreviations

" Use the :abbreviate command to define abbreviations.
" :ab  -- List all abbreviations
" https://github.com/yuhc/yuhc-vim/blob/master/abbreviations.vim

" https://vim.fandom.com/wiki/Category:Abbreviations

"+yg_

" -----------------------------------------------------------------
" The 'helpgrep' command is very useful for searching through all the files located in the .vim/doc directory.
" This allows me to type :H uganda to search for the word 'uganda' in all of the help files.
cnoreabbrev H helpgrep


" https://github.com/Happy-Dude/dotfiles
" From https://stackoverflow.com/posts/3879737/revisions
" :hs command abbreviation/ alias for :split (horizontal split)
" Provides some consistency for :vs (shorthand for :vsplit, vertical split)
cnoreabbrev <expr> hs ((getcmdtype() is# ':' && getcmdline() is# 'hs')?('split'):('hs'))

" https://vim.fandom.com/wiki/Using_abbreviations

" -----------------------------------------------------------------
" To get a C-style comment when you type 'com', you can add this to your .vimrc file:
" iab com /*<CR><space>*<CR><Left>*/<Up>

iab cl --[[<CR><ESC>

" -----------------------------------------------------------------
" Here are some useful abbreviations for Java code:

" iabbrev psvm public static void main(String[] args){<CR>}<esc>O
" iabbrev sysout System.out.println("");<esc>2hi
" iabbrev sop System.out.println("");<esc>2hi
" iabbrev syserr System.err.println("");<esc>2hi
" iabbrev sep System.err.println("");<esc>2hi
"
" iabbrev forl for (int i = 0; i < ; i++) {<esc>7hi
" iabbrev tryb try {<CR>} catch (Exception ex) {<CR> ex.printStackTrace();<CR>}<esc>hx3ko
" iabbrev const public static final int
"
" iabbrev ctm System.currentTimeMillis()
" iabbrev slept try {<CR> Thread.sleep();<CR>}<esc>hxA catch(Exception ex) {<CR> ex.printStackTrace();<CR>}<esc>hx3k$hi

" -----------------------------------------------------------------
" iabbrev DU DSLAM uređaj<space><space>
iabbrev DU DSLAM uređaj<space><space><Esc>0j

" niti 1, 2  (LC kon)
iabbrev UKO niti 1, 2  (LC kon)<Esc>0"+yg_

iabbrev c6 ------------------------------------------------------------<Esc>0Y
iabbrev c2 --------------------<Esc>0Y
iabbrev c1 ----------<Esc>0Y



