
function! gevdoc#model#header#lines(file_path) abort
    let name = fnamemodify(a:file_path, ':t')
    let tag = gevdoc#model#tag#new(name)
    return [tag]
endfunction
