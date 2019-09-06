
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let document_writer = gevdoc#document_writer#new()
    let output_writer = gevdoc#output_writer#new()
    let options = call('gevdoc#option#parse', a:args)

    return gevdoc#generate(plugin_path, document_writer, output_writer, options)
endfunction

function! gevdoc#generate(plugin_path, document_writer, output_writer, options) abort
    let document = gevdoc#model#document#new(a:plugin_path, a:options)
    let lines = document.lines()

    if !a:options['dry-run']
        call a:document_writer.write(document.file_path, lines)
    endif

    if !a:options['quiet']
        call a:output_writer.write(lines)
    endif

    return document
endfunction
