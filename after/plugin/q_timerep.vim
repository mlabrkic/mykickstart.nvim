" https://realpython.com/python-string-split-concatenate-join/

function! TimeReporting()

python3 << ENDpython
import vim

i = 0
s = ", "
b = vim.current.buffer

for b_line in b:
    b_line = b[i]
    b_line_2 = b_line.replace("\t", ",")
    b_line_ar = b_line_2.split(',')
    strings = ["Izrada TR-a", b_line_ar[0], b_line_ar[1], b_line_ar[2]]
    b[i] = s.join(strings)
    i=i+1

ENDpython

endfunction


command! QtimeReporting :call TimeReporting()
" nmap ,tr :call TimeReporting()
