
let s:gevdoc_root = expand('<sfile>:h')

function! s:print_error(throwpoint, exception) abort
    $ put =a:throwpoint
    $ put =a:exception
    1 delete _
    % print
endfunction

function! s:main() abort
    let &runtimepath = s:gevdoc_root . ',' . &runtimepath

    let err = v:false
    try
        call gevdoc#main(argv())
    catch
        let err = v:true
        call s:print_error(v:throwpoint, v:exception)
    finally
        if err
            cquit
        endif
        qall!
    endtry
endfunction

call s:main()
