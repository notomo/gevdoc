
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
