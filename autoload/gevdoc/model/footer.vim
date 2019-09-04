
function! gevdoc#model#footer#lines(textwidth) abort
    let modeline = printf('vim:tw=%s:ft=help', a:textwidth)
    return [modeline]
endfunction
