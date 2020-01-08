
let s:helper = GevdocTestHelper()
let s:suite = s:helper.suite('autoload.gevdoc')
let s:assert = s:helper.assert()

function! s:suite.generate()
    cd ./test/autoload

    let path = '.'
    let document_writer = s:helper.log_document_writer()
    let output_writer = s:helper.output_writer()
    let options = gevdoc#option#parse('--exclude', '_test_data/excluded')

    let document = gevdoc#generate(path, document_writer, output_writer, options)

    call s:assert.true(output_writer.called)

    let expected_path = fnamemodify(path, ':p') . 'doc/autoload.txt'
    call s:assert.equals(document_writer.file_path, expected_path)

    call s:helper.dump(document_writer.lines)

    call s:assert.match(document_writer.lines[0], '^\*autoload.txt\*')

    let commands_index = s:helper.search('^COMMANDS') - 1
    call s:assert.match(document_writer.lines[commands_index], '^COMMANDS')
    call s:assert.match(document_writer.lines[commands_index], '\*autoload-commands\*$')

    call s:assert.match(document_writer.lines[commands_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[commands_index + 2], '^:GevdocTestCommand')
    call s:assert.match(document_writer.lines[commands_index + 2], '\*:GevdocTestCommand\*$')
    call s:assert.match(document_writer.lines[commands_index + 3], '^  test command$')

    call s:assert.not_found('GevdocTestExcluded')

    let hl_index = s:helper.search('^HIGHLIGHT GROUPS') - 1
    call s:assert.match(document_writer.lines[hl_index], '^HIGHLIGHT GROUPS')
    call s:assert.match(document_writer.lines[hl_index], '\*autoload-highlight-groups\*$')

    call s:assert.match(document_writer.lines[hl_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[hl_index + 2], '^GevDocTestHighlight')
    call s:assert.match(document_writer.lines[hl_index + 2], '\*GevDocTestHighlight\*$')
    call s:assert.match(document_writer.lines[hl_index + 3], '  test highlight group')

    let mapping_index = s:helper.search('^MAPPINGS') - 1
    call s:assert.match(document_writer.lines[mapping_index], '^MAPPINGS')
    call s:assert.match(document_writer.lines[mapping_index], '\*autoload-mappings\*$')

    call s:assert.match(document_writer.lines[mapping_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[mapping_index + 2], '^<Plug>(gevdoc-test)')
    call s:assert.match(document_writer.lines[mapping_index + 2], '\*<Plug>(gevdoc-test)\*$')
    call s:assert.match(document_writer.lines[mapping_index + 3], '  test mapping')

    call s:assert.match(document_writer.lines[mapping_index + 4], '', 'empty line')

    call s:assert.match(document_writer.lines[mapping_index + 5], '^<Plug>(gevdoc-indent-test)')
    call s:assert.match(document_writer.lines[mapping_index + 5], '\*<Plug>(gevdoc-indent-test)\*$')
    call s:assert.match(document_writer.lines[mapping_index + 6], '  indent test mapping')

    let variables_index = s:helper.search('^VARIABLES') - 1
    call s:assert.match(document_writer.lines[variables_index], '^VARIABLES')
    call s:assert.match(document_writer.lines[variables_index], '\*autoload-variables\*$')

    call s:assert.match(document_writer.lines[variables_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[variables_index + 2], '^g:gevdoc_test')
    call s:assert.match(document_writer.lines[variables_index + 2], '\*g:gevdoc_test\*$')
    call s:assert.match(document_writer.lines[variables_index + 3], '^  test global variable$')
    call s:assert.match(document_writer.lines[variables_index + 4], '^  multi line description$')

    call s:assert.match(document_writer.lines[mapping_index + 5], '', 'empty line')

    call s:assert.match(document_writer.lines[variables_index + 6], '^b:gevdoc_test')
    call s:assert.match(document_writer.lines[variables_index + 6], '\*b:gevdoc_test\*$')
    call s:assert.match(document_writer.lines[variables_index + 7], '^  test buffer variable$')

    let functions_index = s:helper.search('^FUNCTIONS') - 1
    call s:assert.match(document_writer.lines[functions_index], '^FUNCTIONS')
    call s:assert.match(document_writer.lines[functions_index], '\*autoload-functions\*$')

    call s:assert.match(document_writer.lines[functions_index + 1], '', 'empty line')

    " TODO: support signature document
    " call s:assert.match(document_writer.lines[functions_index + 2], '^gevdoc#test({id}, {name})')
    call s:assert.match(document_writer.lines[functions_index + 2], '^gevdoc#test()')
    call s:assert.match(document_writer.lines[functions_index + 2], '\*gevdoc#test()\*$')
    call s:assert.match(document_writer.lines[functions_index + 3], '^  test autoload function$')

    let variables_index = s:helper.search('^AUTOCMD EVENTS') - 1
    call s:assert.match(document_writer.lines[variables_index], '^AUTOCMD EVENTS')
    call s:assert.match(document_writer.lines[variables_index], '\*autoload-autocmd-events\*$')

    call s:assert.match(document_writer.lines[variables_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[variables_index + 2], '^GevdocTested')
    call s:assert.match(document_writer.lines[variables_index + 2], '\*GevdocTested\*$')
    call s:assert.match(document_writer.lines[variables_index + 3], '^  test autocmd event$')

    call s:assert.match(document_writer.lines[-1], '^vim:')
    call s:assert.match(document_writer.lines[-1], ':tw=78:')
    call s:assert.match(document_writer.lines[-1], ':ts=8:')
    call s:assert.match(document_writer.lines[-1], ':ft=help')
endfunction

function! s:suite.quiet_option() abort
    cd ./test/autoload

    let path = '.'
    let document_writer = s:helper.noop_document_writer()
    let output_writer = s:helper.output_writer()
    let options = gevdoc#option#parse('--quiet')

    let document = gevdoc#generate(path, document_writer, output_writer, options)

    call s:assert.false(output_writer.called)
endfunction

function! s:suite.dryrun_option() abort
    cd ./test/autoload

    let path = '.'
    let document_writer = s:helper.noop_document_writer()
    let output_writer = s:helper.output_writer()
    let options = gevdoc#option#parse('--dry-run')

    let document = gevdoc#generate(path, document_writer, output_writer, options)

    call s:assert.false(document_writer.called, 'document_writer.write must not be called')
    call s:assert.true(output_writer.called, 'output_writer.write must be called')
endfunction

function! s:suite.chapters_option() abort
    cd ./test/autoload

    let path = '.'
    let document_writer = s:helper.log_document_writer()
    let output_writer = s:helper.output_writer()
    let options = gevdoc#option#parse('--chapters', 'highlight groups')

    let document = gevdoc#generate(path, document_writer, output_writer, options)

    call s:helper.dump(document_writer.lines)

    call s:assert.match(document_writer.lines[0], '^\*autoload.txt\*')

    call s:assert.not_found('COMMANDS')

    let hl_index = s:helper.search('^HIGHLIGHT GROUPS') - 1
    call s:assert.match(document_writer.lines[hl_index], '^HIGHLIGHT GROUPS')
    call s:assert.match(document_writer.lines[hl_index], '\*autoload-highlight-groups\*$')

    call s:assert.match(document_writer.lines[hl_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[hl_index + 2], '^GevDocTestHighlight')
    call s:assert.match(document_writer.lines[hl_index + 2], '\*GevDocTestHighlight\*$')
    call s:assert.match(document_writer.lines[hl_index + 3], '  test highlight group')

    call s:assert.not_found('MAPPINGS')
endfunction

function! s:suite.external_option() abort
    cd ./test/autoload

    let path = '.'
    let document_writer = s:helper.log_document_writer()
    let output_writer = s:helper.output_writer()
    let options = gevdoc#option#parse('--chapters', 'introduce', 'commands', 'examples', '--externals', './_test_data/examples.vim', './_test_data/introduce')

    let document = gevdoc#generate(path, document_writer, output_writer, options)

    call s:helper.dump(document_writer.lines)

    call s:assert.match(document_writer.lines[0], '^\*autoload.txt\*')

    let introduce_index = s:helper.search('^INTRODUCE') - 1
    call s:assert.match(document_writer.lines[introduce_index], '^INTRODUCE')
    call s:assert.match(document_writer.lines[introduce_index], '\*autoload-introduce\*$')

    call s:assert.match(document_writer.lines[introduce_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[introduce_index + 2], '^example plugin$')

    let commands_index = s:helper.search('^COMMANDS') - 1
    call s:assert.match(document_writer.lines[commands_index], '^COMMANDS')
    call s:assert.match(document_writer.lines[commands_index], '\*autoload-commands\*$')

    call s:assert.match(document_writer.lines[commands_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[commands_index + 2], '^:GevdocTestCommand')
    call s:assert.match(document_writer.lines[commands_index + 2], '\*:GevdocTestCommand\*$')
    call s:assert.match(document_writer.lines[commands_index + 3], '^  test command$')

    let examples_index = s:helper.search('^EXAMPLES') - 1
    call s:assert.match(document_writer.lines[examples_index], '^EXAMPLES')
    call s:assert.match(document_writer.lines[examples_index], '\*autoload-examples\*$')

    call s:assert.match(document_writer.lines[commands_index + 1], '', 'empty line')

    call s:assert.match(document_writer.lines[examples_index + 2], '>', 'start code')
    call s:assert.match(document_writer.lines[examples_index + 3], '^  nnoremap <Plug>(gevdoc-test) :<C-u>GevdocTestCommand<CR>$')
    call s:assert.match(document_writer.lines[examples_index + 4], '')
endfunction
