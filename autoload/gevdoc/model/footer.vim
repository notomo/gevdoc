
function! gevdoc#model#footer#lines(width, tabstop) abort
    let modeline = printf('vim:tw=%s:ts=%s:ft=help', a:width, a:tabstop)
    return [modeline]
endfunction
