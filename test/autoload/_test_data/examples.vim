nnoremap <Plug>(gevdoc-test) :<C-u>GevdocTestCommand<CR>

" nvim only
if has('nvim')
    cnoremap <Plug>(gevdoc-test) <Cmd>GevdocTestCommand<CR>
endif
