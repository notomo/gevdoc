
function! gevdoc#model#definition#command#parse(factors) abort
    for factor in a:factors[1:]
        if factor[0] !=? '-'
            return gevdoc#model#definition#command#new(factor)
        endif
    endfor

    throw 'failed to parse command: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#command#new(name) abort
    let command = {
        \ 'name': ':' . a:name,
        \ 'type': 'command',
    \ }

    return command
endfunction
