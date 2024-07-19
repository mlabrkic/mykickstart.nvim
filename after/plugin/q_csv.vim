" date: 2022-11M-26 17:04:13
" ------------------------------------------------------------
" https://vim.fandom.com/wiki/Working_with_CSV_files

" ------------------------------------------------------------
" Highlighting a column

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight

function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    " delimiter , (4x)
    " execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    " execute 'normal! 0'.n.'f,'

    " delimiter ; (4x)
    execute 'match Keyword /^\([^;]*;\)\{'.n.'}\zs[^;]*/'
    execute 'normal! 0'.n.'f;'
  elseif a:colnr == 1
    " match Keyword /^[^,]*/    " delimiter ,
    match Keyword /^[^;]*/    " delimiter ;
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" ------------------------------------------------------------

