
let s:suite = themis#suite('autoload.gevdoc')
let s:assert = themis#helper('assert')

function! s:suite.before_each()
    call GevdocTestBeforeEach()
endfunction

function! s:suite.after_each()
    call GevdocTestAfterEach()
endfunction

function! s:writer() abort
    let writer = {'lines': v:null, 'file_path': v:null}

    function! writer.write(file_path, lines) abort
        call themis#log('[path] ' . a:file_path)
        for line in a:lines
            call themis#log('[file] ' . line)
        endfor

        let self.lines = a:lines
        let self.file_path = a:file_path
    endfunction

    return writer
endfunction

function! s:suite.generate()
    cd ./test/autoload

    let path = '.'
    let writer = s:writer()

    let doc = gevdoc#generate('.', writer, {'exclude': ['_test_data/excluded']})

    let expected_path = fnamemodify(path, ':p') . 'doc/autoload.txt'
    call s:assert.equals(doc.file_path, expected_path)
    call s:assert.equals(writer.file_path, expected_path)

    call s:assert.match(writer.lines[0], '^\*autoload.txt\*')

    call s:assert.match(writer.lines[3], '^COMMANDS')
    call s:assert.match(writer.lines[3], '\*autoload-commands\*$')

    call s:assert.match(writer.lines[5], '^:GevdocTest')
    call s:assert.match(writer.lines[5], '\*:GevdocTest\*$')

    let lines = join(writer.lines, "\n")
    call s:assert.not_match(lines, '.*GevdocTestExcluded.*')

    call s:assert.match(writer.lines[-1], '^vim:')
endfunction
