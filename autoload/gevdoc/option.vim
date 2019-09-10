
let s:options = {
    \ 'exclude': [],
    \ 'quiet': v:false,
    \ 'dry-run': v:false,
    \ 'chapters': ['commands', 'highlight groups', 'mappings', 'variables', 'functions', 'autocmd events'],
\ }

function! gevdoc#option#parse(...) abort
    let options = deepcopy(s:options)

    let default_lists = {}
    for [k, v] in items(s:options)
        if type(v) != v:t_list || empty(v)
            continue
        endif
        let default_lists[k] = v
        let options[k] = []
    endfor

    let key = ''
    for arg in a:000
        if arg[:1] ==? '--' && has_key(options, arg[2:])
            let _key = arg[2:]
            let value = options[_key]
            if type(value) == v:t_bool
                let options[_key] = v:true
                continue
            endif

            let key = _key
            continue
        endif

        if has_key(options, key)
            let value = options[key]
            call add(value, arg)
        endif
    endfor

    for [k, v] in items(default_lists)
        if !empty(options[k])
            continue
        endif
        let options[k] = v
    endfor

    return options
endfunction
