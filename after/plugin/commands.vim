" date: 2022-10M-05 09:49:29

" ------------------------------------------------------------
" https://github.com/nanotee/nvim-lua-guide#vimcmd

" https://neovim.io/doc/user/api.html#nvim_create_autocmd()
" h nvim_create_autocmd()

" ------------------------------------------------------------

" ------------------------ COMMANDS --------------------------
" https://github.com/nilesr/dotfiles/blob/master/.vim/vimrc

" ------------------------------------------------------------
" MyCommand 01:
" Remove spaces at the end of lines

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" autocmd FileType text,python,go,html,typescript,javascript autocmd BufWritePre <buffer> call TrimWhitespace()
" autocmd FileType * autocmd BufWritePre <buffer> call TrimWhitespace()

nnoremap <C-t> :call TrimWhitespace()<CR>

" ------------------------------------------------------------
" MyCommand 02:
" Function to insert the current date

" https://vim.fandom.com/wiki/Insert_current_date_or_time
" :r !date /t

" nnoremap <F5> "=strftime("%c")<CR>P
" nnoremap <F5> "=strftime('%Y-%m-%d %H:%M:%S')<CR>P
" nnoremap <S-t> :r !date /t<CR>

" :call setreg('a', "1\n2\n3", 'b5')

function! InsertCurrentDate()
" let curr_date=strftime('%Y-%m-%d %T %H:%M:%S', localtime())
" return curr_date

" call setreg('+', curr_date)
" let @a = curr_date
let @a = strftime('date: %Y-%mM-%d %H:%M:%S', localtime())
" return @a
endfunction

" https://vim.fandom.com/wiki/Pasting_registers
" In normal and visual modes, "xp pastes the contents of the register x.

" command! Qdate :call InsertCurrentDate()
" "ap

" nnoremap <S-t> :let @a = strftime('%Y-%mM-%d %H:%M:%S', localtime())<CR>"ap
nnoremap <F2> :call InsertCurrentDate()<CR>"ap

" ----------------------------------------------------------
" MyCommand 03:
" ---------------
" Write Buffer if Necessary
"
" Writes the current buffer if it's needed, unless we're the in QuickFix mode.
" ---------------

function WriteBufferIfNecessary()
  if &modified && !&readonly
    :write
  endif
endfunction
command! WriteBufferIfNecessary call WriteBufferIfNecessary()

function CRWriteIfNecessary()
  if &filetype == "qf" || &filetype == "ctrlsf"
    " Execute a normal enter when in Quickfix or Ctrlsf plugin.
    execute "normal! \<enter>"
  else
    WriteBufferIfNecessary
  endif
endfunction

" Save the file if necessary when hitting enter
" Idea for MapCR from http://git.io/pt8kjA
function! MapCR()
  nnoremap <silent> <enter> :call CRWriteIfNecessary()<CR>
endfunction
call MapCR()

" ----------------------------------------------------------
" MyCommand 04:
" Edit init.vim and cd to folder:
" command! QeditVIMRC :e $MYVIMRC | tcd %:h

" SV will re-source this .vimrc file.
" command! QsourceVIMRC :update $MYVIMRC | luafile $MYVIMRC

" command! QsourceVIMRC :update $MYVIMRC | luafile $MYVIMRC |
"       \ call v:lua.vim.notify("Nvim config successfully reloaded!", 2, {'title': 'nvim-config'})

" ----------------------------------------------------------
" MyCommand 05:
" Toggle line numbers on or off.
command! QnumberRelativ set relativenumber!

" ----------------------------------------------------------
" MyCommand 06:
" Toggle cursor column

" https://github.com/jdhao/nvim-config
" function! utils#ToggleCursorCol() abort
function! s:ToggleCursorCol()
  if &cursorcolumn
    set nocursorcolumn
    echo 'cursorcolumn: OFF'
  else
    set cursorcolumn
    echo 'cursorcolumn: ON'
  endif
endfunction

command! QcursorColToggle :call <SID>ToggleCursorCol()

" nnoremap <silent> <leader>cl :<C-U>call ToggleCursorCol()<CR>

" ----------------------------------------------------------
" Always use very magic mode for searching
" nnoremap / /\v


" WR will force a write to a file you do not have permissions to modify.
" command! WW w !sudo tee % > /dev/null

" ----------------------------------------------------------
" MyCommand 07:
" Toggle colorcolumn 80 in Vim

set colorcolumn=""
" set colorcolumn=80,120

function! s:ToggleColorColumn()
    if &colorcolumn == ""
        set colorcolumn=80,120
    else
        set colorcolumn=""
    endif
endfunction

" nnoremap <silent><F6> :call <SID>ToggleColorColumn()<cr>
command! QcolorColumn80Toggle :call <SID>ToggleColorColumn()


" https://github.com/mfussenegger/dotfiles
" vim.opt.colorcolumn = '80'      -- Line lenght marker at 80 columns
" augroup colorcol
"   autocmd!
"   autocmd InsertEnter * set colorcolumn=80,120
"   autocmd InsertLeave * set colorcolumn=""
" augroup end

" ----------------------------------------------------------
" MyCommand 08:
" RemoveFancyCharacters

" Remove smart quotes, etc.
function! RemoveFancyCharacters()
	let typo = {}
	let typo["„"] = '"'  " mlabrkic
	let typo["“"] = '"'
	let typo["”"] = '"'
	let typo["‘"] = "'"
	let typo["’"] = "'"
	let typo["–"] = '--'
	let typo["—"] = '---'
	let typo["…"] = '...'
	:exe ":%s/".join(keys(typo), '\|').'/\=typo[submatch(0)]/ge'
endfunction
command! QfixRemoveFancyCharacters :call RemoveFancyCharacters()

" ------------------------------------------------------------
" MyCommand 09:
" Change_between_backslash_and_forward_slash

" https://vim.fandom.com/wiki/Change_between_backslash_and_forward_slash
function! ToggleSlash(independent) range
  let from = ''
  for lnum in range(a:firstline, a:lastline)
    let line = getline(lnum)
    let first = matchstr(line, '[/\\]')
    if !empty(first)
      if a:independent || empty(from)
        let from = first
      endif
      let opposite = (from == '/' ? '\' : '/')
      call setline(lnum, substitute(line, from, opposite, 'g'))
    endif
  endfor
endfunction
command! -bang -range QToggleSlash <line1>,<line2>call ToggleSlash(<bang>1)

" noremap <silent> <F8> :QToggleSlash<CR>

" Enter :ToggleSlash! to force changes to each selected line to be the same:
" if the first slash found is a forward slash, all slashes in all selected lines are changed to backslashes;
" otherwise, all slashes in all selected lines are changed to forward slashes.

" ------------------------------------------------------------
" MyCommand 10:
" Redirect command output to a register for later processing.

" https://github.com/jdhao/nvim-config
" Ref: https://stackoverflow.com/q/2573021/6064933 and https://unix.stackexchange.com/q/8101/221410 .
function! CaptureCommandOutput(command) abort
  let l:tmp = @m
  redir @m
  silent! execute a:command
  redir END

  "create a scratch buffer for dumping the text, ref: https://vi.stackexchange.com/a/11311/15292.
  tabnew | setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile

  let l:lines = split(@m, '\n')
  call nvim_buf_set_lines(0, 0, 0, 0, l:lines)

  let @m = l:tmp
endfunction

" Capture output from a command to register @m,
" to paste, press "mp
command! -nargs=1 -complete=command QRedir call CaptureCommandOutput(<q-args>)

" https://vim.fandom.com/wiki/Vim_Tips_Wiki
" https://vim.fandom.com/wiki/Capture_ex_command_output

" Example usage:
" :QRedir echo stdpath('config')

" ------------------------------------------------------------
" MyCommand 11:
" visual-at. Allow running macro's over a visual selection, just type @<reg>
" while in visual mode.

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" ----------------------------------------------------------
" MyCommand 12:
" ---------------
" Make a scratch buffer with all of the leader keybindings.
"
" Adapted from http://ctoomey.com/posts/an-incremental-approach-to-vim/
" ---------------
function! ListLeaders()
  silent! redir @b
  silent! nmap <LEADER>
  silent! redir END
  " silent! new
  silent! enew
  silent! set buftype=nofile
  silent! set bufhidden=hide
  silent! setlocal noswapfile
  silent! put! b
  silent! g/^s*$/d
  silent! %s/^.*,//
  silent! normal ggVg
  silent! sort
  silent! let lines = getline(1,"$")
  silent! normal <esc>
endfunction

command! QListLeaders :call ListLeaders()

" ----------------------------------------------------------
" MyCommand 13:

function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register QCopyMatches call CopyMatches(<q-reg>)

" ----------------------------------------------------------
" MyCommand 14:
" https://github.com/jdhao/nvim-config
" nvim-config\autoload\utils.vim

" https://github.com/wbthomason/packer.nvim/discussions/534

augroup git_repo_check
  autocmd!
  autocmd VimEnter,DirChanged * call Inside_git_repo()
augroup END

" Check if we are inside a Git repo.
" function! utils#Inside_git_repo() abort
function! Inside_git_repo() abort
  let res = system('git rev-parse --is-inside-work-tree')
  if match(res, 'true') == -1
    return v:false
  else
    " Trigger a special user autocmd InGitRepo (to use it for
    " lazyloading of fugitive by packer.nvim).
    doautocmd User InGitRepo
    return v:true
  endif
endfunction




" ----------------------------------------------------------
" Visual mode pressing * or # searches for the current selection

" https://vim.fandom.com/wiki/Search_for_visually_selected_text

" https://github.com/amix/vimrc
" Super useful! From an idea by Michael Naumann

" vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
" vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" function! CmdLine(str)
"     call feedkeys(":" . a:str)
" endfunction
"
" function! VisualSelection(direction, extra_filter) range
"     let l:saved_reg = @"
"     execute "normal! vgvy"
"
"     let l:pattern = escape(@", "\\/.*'$^~[]")
"     let l:pattern = substitute(l:pattern, "\n$", "", "")
"
"     if a:direction == 'gv'
"         " call CmdLine("Ack '" . l:pattern . "' " )
"         call CmdLine("rg '" . l:pattern . "' " )
"     elseif a:direction == 'replace'
"         call CmdLine("%s" . '/'. l:pattern . '/')
"     endif
"
"     let @/ = l:pattern
"     let @" = l:saved_reg
" endfunction


" makes * and # work on visual mode too.
" https://github.com/folke/dot/tree/master/config/nvim
" function! g:VSetSearch(cmdtype)
"
"   let temp = @s
"   norm! gv"sy
"   let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
"   let @s = temp
" endfunction
"
" xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
" xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" ------------------------------------------------------------

