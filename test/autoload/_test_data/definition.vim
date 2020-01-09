
"" test command
command! GevdocTestCommand echo 'ok'

"" test highlight group
highlight default link GevDocTestHighlight Comment

"" test mapping
nnoremap <unique> <silent><Plug>(gevdoc-test) :<C-u>GevdocTestCommand<CR>

if v:true
    "" indent test mapping
    nnoremap <Plug>(gevdoc-indent-test) :<C-u>GevdocTestCommand<CR>
endif

"" test global variable
" multi line description
let g:gevdoc_test = 1

"" test buffer variable
let b:gevdoc_test = 1

"" test autoload function
function! gevdoc#test(id, name) abort
endfunction

"" test autocmd event
doautocmd <nomodeline> User GevdocTested

"" code in doc
" ```
" GevdocTestCodeInDoc " no echo
"
" GevdocTestCodeInDoc 'test' " echo test
" ```
command! -nargs=? GevdocTestCodeInDoc echo <args>
