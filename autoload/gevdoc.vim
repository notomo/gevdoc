
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let document_writer = gevdoc#document_writer#new()
    let output_writer = gevdoc#output_writer#new()
    let options = call('gevdoc#option#parse', a:args)

    return gevdoc#generate(plugin_path, document_writer, output_writer, options)
endfunction

function! gevdoc#generate(plugin_path, document_writer, output_writer, options) abort
    let plugin = gevdoc#model#plugin#new(a:plugin_path)

    let sections = []
    for file in gevdoc#file#find(plugin.path, a:options['exclude'])
        let sections += gevdoc#model#section#all(file.read())
    endfor
    for file in gevdoc#file#externals(plugin.path, a:options['externals'])
        let sections += gevdoc#model#section#external(file)
    endfor
    let chapters = gevdoc#model#chapter#all(a:options['chapters'], sections, plugin.name)

    let file_path = plugin.file_path()
    let document = gevdoc#model#document#new(file_path, chapters)
    let lines = document.lines()

    if !a:options['dry-run']
        call a:document_writer.write(file_path, lines)
    endif

    if !a:options['quiet']
        call a:output_writer.write(lines)
    endif

    return document
endfunction
