
function! gevdoc#model#definition#highlight_group#parse(factors) abort
    for factor in a:factors[1:]
        if factor !=# 'default' && factor !=# 'link'
            return gevdoc#model#definition#highlight_group#new(factor)
        endif
    endfor

    throw 'failed to parse hightlight group: ' . string(a:factors)
endfunction

function! gevdoc#model#definition#highlight_group#new(name) abort
    let highlight_group = {
        \ 'name': a:name,
        \ 'type': 'highlight group',
    \ }

    return highlight_group
endfunction
