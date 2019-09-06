
function! gevdoc#model#footer#lines(width) abort
    let modeline = printf('vim:tw=%s:ft=help', a:width)
    return [modeline]
endfunction
