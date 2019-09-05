
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let document_writer = gevdoc#document_writer#new()
    let output_writer = gevdoc#output_writer#new()
    let options = call('gevdoc#option#parse', a:args)

    return gevdoc#generate(plugin_path, document_writer, output_writer, options)
endfunction

function! gevdoc#generate(plugin_path, document_writer, output_writer, options) abort
    let doc = gevdoc#model#doc#new(a:plugin_path, a:options)
    let lines = doc.lines()
    call a:document_writer.write(doc.file_path, lines)

    if !a:options['quiet']
        call a:output_writer.write(lines)
    endif

    return doc
endfunction
