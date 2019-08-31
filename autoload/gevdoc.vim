
function! gevdoc#main(args) abort
    let path = a:args[0]
    let writer = gevdoc#writer#new()

    return gevdoc#generate(path, writer)
endfunction

function! gevdoc#generate(path, writer) abort
    let doc = gevdoc#model#doc#new(a:path)
    call a:writer.write(doc)
    return doc
endfunction
