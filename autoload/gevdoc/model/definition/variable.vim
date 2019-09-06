
function! gevdoc#model#definition#variable#parse(factors) abort
    for factor in a:factors[1:]
        return gevdoc#model#definition#variable#new(factor)
    endfor

    throw 'failed to parse variable: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#variable#new(name) abort
    let definition = {
        \ 'name': a:name,
        \ 'type': 'variables',
    \ }

    return definition
endfunction
