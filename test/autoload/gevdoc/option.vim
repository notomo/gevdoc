
let s:helper = GevdocTestHelper()
let s:suite = s:helper.suite('autoload.gevdoc.option')
let s:assert = s:helper.assert()

function! s:suite.parse_default() abort
    let options = gevdoc#option#parse()

    call s:assert.equals(options['exclude'], [])
    call s:assert.false(options['quiet'])
    call s:assert.false(options['dry-run'])
endfunction

function! s:suite.parse() abort
    let options = gevdoc#option#parse('--exclude', './excluded', '--quiet', '--exclude', './excluded2', '--dry-run', '--chapters', 'commands')

    call s:assert.equals(options['exclude'], ['./excluded', './excluded2'])
    call s:assert.equals(options['chapters'], ['commands'])
    call s:assert.true(options['quiet'])
    call s:assert.true(options['dry-run'])
endfunction
