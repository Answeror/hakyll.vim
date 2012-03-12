" vim:tabstop=2:shiftwidth=2:expandtab:foldmethod=marker:textwidth=79
" Hakyll plugin file
" Author: Answeror <answeror@gmail.com>

if exists("loaded_hakyll") || &cp
  finish
endif
let loaded_hakyll = 1

let s:old_cpo = &cpo
set cpo&vim

function! HakyllGet(option) "{{{
  if !has_key(g:hakyll_options, a:option) &&
        \ has_key(s:hakyll_defaults, a:option)
    let g:hakyll_options[a:option] =
          \s:hakyll_defaults[a:option]
  endif

  " if path's ending is not a / or \
  " then add it
  if a:option == 'path'
    let p = g:hakyll_options[a:option]
    " resolve doesn't work quite right with symlinks ended with / or \
    let p = substitute(p, '[/\\]\+$', '', '')
    let p = resolve(expand(p))
    let g:hakyll_options[a:option] = p.'/'
  endif

  return g:hakyll_options[a:option]
endfunction "}}}

" CALENDAR Hook "{{{
if g:hakyll_use_calendar
  let g:calendar_action = 'hakyll#diary#calendar_action'
  let g:calendar_sign = 'hakyll#diary#calendar_sign'
endif
"}}}

" default options {{{
let s:hakyll_defaults = {}
let s:hakyll_defaults.path = '~/hakyll'
let s:hakyll_defaults.ext = '.md'
" }}}

let &cpo = s:old_cpo
