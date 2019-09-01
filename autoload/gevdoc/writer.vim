
function! gevdoc#writer#new() abort
    let writer = {}

    function! writer.write(file_path, lines) abort
        let directory = fnamemodify(a:file_path, ':h')
        call mkdir(directory, 'p')
        call writefile(a:lines, a:file_path)
    endfunction

    return writer
endfunction
