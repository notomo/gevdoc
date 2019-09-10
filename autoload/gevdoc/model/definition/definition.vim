
function! gevdoc#model#definition#definition#parse(line) abort
    let factors = split(a:line, '\v\s+')
    if factors[0] =~# '^com'
        return gevdoc#model#definition#command#parse(factors)
    elseif factors[0] =~# '^hi'
        return gevdoc#model#definition#highlight_group#parse(factors)
    elseif factors[0] =~# '^\w*noremap'
        return gevdoc#model#definition#plug_mapping#parse(factors)
    elseif len(factors) > 2 && factors[0] ==# 'let' && factors[1] =~# '^[gb]:'
        return gevdoc#model#definition#variable#parse(factors)
    elseif len(factors) > 2 && factors[0] =~# '^fu' && factors[1] =~# '.*#'
        return gevdoc#model#definition#autoload_function#parse(factors)
    elseif factors[0] =~# '^do'
        return gevdoc#model#definition#autocmd_event#parse(factors)
    endif

    throw 'not supported factor: ' . factors[0]
endfunction
