
function! gevdoc#writer#new() abort
    let writer = {}

    function! writer.write(doc) abort
        call writefile(a:doc.lines(), a:doc.path)
    endfunction

    return writer
endfunction
