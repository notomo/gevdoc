
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let document_writer = gevdoc#document_writer#new()
    let output_writer = gevdoc#output_writer#new()
    let options = s:parse_options(a:args)

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

let s:options = {
    \ 'exclude': [],
    \ 'quiet': v:false,
\ }

function! s:parse_options(args) abort
    let options = deepcopy(s:options)
    let key = ''
    for arg in a:args
        if arg[:1] ==? '--' && has_key(options, arg[2:])
            let key = arg[2:]
        elseif has_key(options, key)
            call add(options[key], arg)
        endif
    endfor

    return options
endfunction
