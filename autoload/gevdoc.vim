
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let writer = gevdoc#writer#new()

    return gevdoc#generate(plugin_path, writer)
endfunction

function! gevdoc#generate(plugin_path, writer) abort
    let doc = gevdoc#model#doc#new(a:plugin_path)
    call a:writer.write(doc.file_path, doc.lines())
    return doc
endfunction
