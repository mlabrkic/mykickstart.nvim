" https://vi.stackexchange.com/questions/4695/quickly-calculate-the-total-of-a-column-of-numbers

" ------------------------------------------------------------
" Actually, it should be like this:

" 1)
" Visually select the column
" y  --> copy into "" (register ")

" 2)
" :QsumLINES

" 3)
" Move where you want the value
" p --> paste value from the unnamed register ""

" :h registers
"  '"'	the unnamed register, containing the text of the last delete or yank

" ============================================================

" 1)
" Visually select the column
" "ay --> copy into "a (register a)
" or
" y (or ""y) --> copy into "" (register ")

" 2)
" :QsumLINES

" ------------------------------
" 3)
" Move where you want the value

    " let @" = substitute(trim(@"), "\<NL>", "+", "g")
" i --> In insert mode:
" CTRL-R =CTRL-R a
" run the replaced "a through the expression register

" ----------
" or
    " let @" = eval(substitute(trim(@"), "\<NL>", "+", "g"))
" p --> paste value from:

" ------------------------------------------------------------
" replace newlines with + and evaluate:
" :echo eval(substitute(@", "\n", '+', 'g'))
" :echo eval(substitute(trim(@"), "\<NL>", "+", "g"))

" spaces and newlines:
" i, C-R --> view content of register a or "
" ^@

" ------------------------------------------------------------
" h pattern.txt

" ------------------------------
" h i_CTRL-R
" h c_CTRL-R

" Special registers:
"  '"'	the unnamed register, containing the text of the last delete or yank

" ------------------------------
" h NL-used-for-Nul

" notation  meaning       equivalent  decimal value(s)  ~
" <NL>    linefeed    CTRL-J   10 (used for <Nul>)

" ------------------------------------------------------------
" :echo eval(substitute(trim(@a), "\<NL>", "+", "g"))

function! Sum()
    " let @a = substitute(trim(@a), "\<c-j>", "+", "g")
    " let @a = substitute(trim(@a), "\<NL>", "+", "g")

    " let @" = substitute(trim(@"), "\<NL>", "+", "g")
    let @" = eval(substitute(trim(@"), "\<NL>", "+", "g"))
endfunction

command! -nargs=0 QsumInColum call Sum()

" ------------------------------------------------------------
" https://jdhao.github.io/2020/01/10/nvim_number_arithmetic_in_substitute/

