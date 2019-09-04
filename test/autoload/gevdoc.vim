
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

    " dump to buffer
    call append(1, writer.lines)
    1delete _

    call s:assert.match(writer.lines[0], '^\*autoload.txt\*')

    let commands_index = search('^COMMANDS', 'n') - 1
    call s:assert.match(writer.lines[commands_index], '^COMMANDS')
    call s:assert.match(writer.lines[commands_index], '\*autoload-commands\*$')

    call s:assert.match(writer.lines[commands_index + 1], '', 'empty line')

    call s:assert.match(writer.lines[commands_index + 2], '^:GevdocTestCommand')
    call s:assert.match(writer.lines[commands_index + 2], '\*:GevdocTestCommand\*$')
    call s:assert.match(writer.lines[commands_index + 3], '^  test command$')

    call s:assert.equals(search('GevdocTestExcluded', 'n'), 0)

    let hl_index = search('^HIGHLIGHT GROUPS', 'n') - 1
    call s:assert.match(writer.lines[hl_index], '^HIGHLIGHT GROUPS')
    call s:assert.match(writer.lines[hl_index], '\*autoload-highlight-groups\*$')

    call s:assert.match(writer.lines[hl_index + 1], '', 'empty line')

    call s:assert.match(writer.lines[hl_index + 2], '^GevDocTestHighlight')
    call s:assert.match(writer.lines[hl_index + 2], '\*GevDocTestHighlight\*$')
    call s:assert.match(writer.lines[hl_index + 3], '  test highlight group')

    let mapping_index = search('^MAPPINGS', 'n') - 1
    call s:assert.match(writer.lines[mapping_index], '^MAPPINGS')
    call s:assert.match(writer.lines[mapping_index], '\*autoload-mappings\*$')

    call s:assert.match(writer.lines[mapping_index + 1], '', 'empty line')

    call s:assert.match(writer.lines[mapping_index + 2], '^<Plug>(gevdoc-test)')
    call s:assert.match(writer.lines[mapping_index + 2], '\*<Plug>(gevdoc-test)\*$')
    call s:assert.match(writer.lines[mapping_index + 3], '  test mapping')

    call s:assert.match(writer.lines[-1], '^vim:')
endfunction
