
let s:options = {
    \ 'exclude': [],
    \ 'quiet': v:false,
    \ 'dry-run': v:false,
\ }

function! gevdoc#option#parse(...) abort
    let options = deepcopy(s:options)

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

    return options
endfunction
