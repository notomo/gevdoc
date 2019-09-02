
function! gevdoc#main(args) abort
    let plugin_path = getcwd()
    let writer = gevdoc#writer#new()
    let options = s:parse_options(a:args)

    return gevdoc#generate(plugin_path, writer, options)
endfunction

function! gevdoc#generate(plugin_path, writer, options) abort
    let doc = gevdoc#model#doc#new(a:plugin_path, a:options)
    call a:writer.write(doc.file_path, doc.lines())
    return doc
endfunction

let s:options = {
    \ 'exclude': [],
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
