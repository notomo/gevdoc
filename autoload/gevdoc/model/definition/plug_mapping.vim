
function! gevdoc#model#definition#plug_mapping#parse(factors) abort
    for factor in a:factors[1:]
        let name = matchstr(factor, '.*\zs<Plug>.*')
        if !empty(name)
            return gevdoc#model#definition#plug_mapping#new(name)
        endif
    endfor

    throw 'failed to parse plug mapping: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#plug_mapping#new(name) abort
    let definition = {
        \ 'name': a:name,
        \ 'type': 'mappings',
    \ }

    return definition
endfunction
