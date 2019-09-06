
function! gevdoc#model#tag#add(target, width, ...) abort
    if !empty(a:000)
        let tag_name = a:000[0]
    else
        let tag_name = a:target
    endif
    let tag = gevdoc#model#tag#new(tag_name)
    let spaces = repeat(' ', a:width - len(tag) - len(a:target))
    return a:target . spaces . tag
endfunction

function! gevdoc#model#tag#new(name) abort
    return printf('*%s*', a:name)
endfunction
