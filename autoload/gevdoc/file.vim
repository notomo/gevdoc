
function! gevdoc#file#find(path, excluded_patterns) abort
    let excluded_pattern = join(a:excluded_patterns, '\|\m')

    let paths = glob(a:path . '**/*.vim', v:true, v:true)
    call map(paths, {_, path -> fnamemodify(path, ':.')})

    if !empty(excluded_pattern)
        call filter(paths, { _, path -> path !~# excluded_pattern })
    endif

    return map(paths, { _, path -> s:new(path) })
endfunction

function! s:new(path) abort
    let f = {'path': a:path}

    function! f.read() abort
        return readfile(self.path)
    endfunction

    return f
endfunction
