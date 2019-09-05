
function! gevdoc#output_writer#new() abort
    let writer = {}

    function! writer.write(lines) abort
        tabedit
        for line in a:lines
            $ put =line
        endfor
        1 delete _
        % print
        % delete _
    endfunction

    return writer
endfunction
