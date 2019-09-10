
function! gevdoc#model#definition#autocmd_event#parse(factors) abort
    for factor in a:factors[1:]
        if factor !=# '<nomodeline>' && factor !=# 'User'
            return gevdoc#model#definition#autocmd_event#new(factor)
        endif
    endfor

    throw 'failed to parse autocmd event: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#autocmd_event#new(name) abort
    let definition = {
        \ 'name': a:name,
        \ 'type': 'autocmd events',
    \ }

    return definition
endfunction
