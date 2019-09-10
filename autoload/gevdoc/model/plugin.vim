
function! gevdoc#model#plugin#new(path) abort
    let full_path = fnamemodify(a:path, ':p')

    let plugin = {
        \ 'path': full_path,
        \ 'name': fnamemodify(full_path, ':h:t'),
    \ }

    function! plugin.file_path() abort
        return self.path . 'doc/' . self.name . '.txt'
    endfunction

    return plugin
endfunction
