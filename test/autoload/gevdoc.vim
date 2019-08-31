
let s:suite = themis#suite('autoload.gevdoc')
let s:assert = themis#helper('assert')

function! s:suite.before_each()
    call TddTestBeforeEach()
endfunction

function! s:suite.after_each()
    call TddTestAfterEach()
endfunction

function! s:noop_writer() abort
    let writer = {}

    function! writer.write(doc) abort
    endfunction

    return writer
endfunction

function! s:suite.generate()
    cd ./test/autoload

    let path = './doc'
    let writer = s:noop_writer()
    let doc = gevdoc#generate(path, writer)

    call s:assert.equals(doc.path, path)
endfunction
