
function! gevdoc#model#doc#new(plugin_path) abort
    let name = fnamemodify(a:plugin_path, ':p:h:t')
    let file_path = fnamemodify(a:plugin_path, ':p') . 'doc/' . name . '.txt'
    let doc = {
        \ 'file_path': file_path,
        \ 'textwidth': 78,
    \ }

    function! doc.lines() abort
        let sep = self.separater()
        return
            \ self.header() +
            \ sep +
            \ self.body() +
            \ sep +
            \ self.footer()
    endfunction

    function! doc.header() abort
        let first_line = printf('*%s*', fnamemodify(self.file_path, ':t'))
        return [first_line]
    endfunction

    function! doc.body() abort
        return ['NOT IMPLEMENTED']
    endfunction

    function! doc.footer() abort
        let last_line = printf('vim:tw=%s:ft=help', self.textwidth)
        return [last_line]
    endfunction

    function! doc.separater() abort
        return ['', repeat('=', self.textwidth)]
    endfunction

    return doc
endfunction
