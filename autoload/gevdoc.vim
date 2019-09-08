
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let document_writer = gevdoc#document_writer#new()
    let output_writer = gevdoc#output_writer#new()
    let options = call('gevdoc#option#parse', a:args)

    return gevdoc#generate(plugin_path, document_writer, output_writer, options)
endfunction

function! gevdoc#generate(plugin_path, document_writer, output_writer, options) abort
    let width = 78

    let plugin_path = fnamemodify(a:plugin_path, ':p')
    let name = fnamemodify(plugin_path, ':h:t')
    let file_path = plugin_path . 'doc/' . name . '.txt'

    let sections = []
    for file in gevdoc#file#find(plugin_path, a:options['exclude'])
        let sections += gevdoc#model#section#all(file.read(), width)
    endfor
    let chapters = gevdoc#model#chapter#all(a:options['chapters'], sections, name, width)

    let document = gevdoc#model#document#new(file_path, width, chapters)
    let lines = document.lines()

    if !a:options['dry-run']
        call a:document_writer.write(file_path, lines)
    endif

    if !a:options['quiet']
        call a:output_writer.write(lines)
    endif

    return document
endfunction
