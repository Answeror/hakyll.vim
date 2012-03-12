" vim:tabstop=2:shiftwidth=2:expandtab:foldmethod=marker:textwidth=79
" Hakyll autoload plugin file
" Desc: Handle diary notes
" Author: Answeror <answeror@gmail.com>

" Load only once {{{
if exists("g:loaded_hakyll_diary_auto") || &cp
  finish
endif
let g:loaded_hakyll_diary_auto = 1
"}}}

function! s:prefix_zero(num) "{{{
  if a:num < 10
    return '0'.a:num
  endif
  return a:num
endfunction "}}}

function! hakyll#diary#make(link) "{{{
python << EOF
import vim, os
link = vim.eval('a:link')
base = vim.eval("HakyllGet('path')")
ext = vim.eval("HakyllGet('ext')")
path = os.path.join(base, 'posts/diary', link + ext)
vim.command('e ' + path)
EOF
endfunction "}}}

" Calendar.vim callback function.
function! hakyll#diary#calendar_action(day, month, year, week, dir) "{{{
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)

  let link = a:year.'-'.month.'-'.day
  if winnr('#') == 0
    if a:dir == 'V'
      vsplit
    else
      split
    endif
  else
    wincmd p
    if !&hidden && &modified
      new
    endif
  endif

  " Create diary note for a selected date in default wiki.
  call hakyll#diary#make(link)
endfunction "}}}

" Calendar.vim sign function.
function hakyll#diary#calendar_sign(day, month, year) "{{{
  let day = s:prefix_zero(a:day)
  let month = s:prefix_zero(a:month)
  let sfile = HakyllGet('path').a:year.'-'.month.'-'.day.HakyllGet('ext')
  return filereadable(expand(sfile))
endfunction "}}}
