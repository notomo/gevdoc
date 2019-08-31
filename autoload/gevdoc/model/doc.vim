
function! gevdoc#model#doc#new(path) abort
    let doc = {'path': a:path}

    function! doc.lines() abort
        return []
    endfunction

    return doc
endfunction
