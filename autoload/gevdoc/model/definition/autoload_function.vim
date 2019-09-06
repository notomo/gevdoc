
function! gevdoc#model#definition#autoload_function#parse(factors) abort
    for factor in a:factors[1:]
        let name = matchstr(factor, '\v^[^(]+')
        return gevdoc#model#definition#autoload_function#new(name)
    endfor

    throw 'failed to parse autoload function: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#autoload_function#new(name) abort
    " TODO: support signature document
    let definition = {
        \ 'name': a:name . '()', 
        \ 'type': 'functions',
        \ 'tag_name': a:name . '()',
    \ }

    return definition
endfunction
