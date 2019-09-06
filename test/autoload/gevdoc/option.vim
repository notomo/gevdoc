
let s:suite = themis#suite('autoload.gevdoc.option')
let s:assert = themis#helper('assert')

function! s:suite.before_each()
    call GevdocTestBeforeEach()
endfunction

function! s:suite.after_each()
    call GevdocTestAfterEach()
endfunction

function! s:suite.parse_default() abort
    let options = gevdoc#option#parse()

    call s:assert.equals(options['exclude'], [])
    call s:assert.false(options['quiet'])
    call s:assert.false(options['dry-run'])
endfunction

function! s:suite.parse() abort
    let options = gevdoc#option#parse('--exclude', './excluded', '--quiet', '--exclude', './excluded2', '--dry-run')

    call s:assert.equals(options['exclude'], ['./excluded', './excluded2'])
    call s:assert.true(options['quiet'])
    call s:assert.true(options['dry-run'])
endfunction
