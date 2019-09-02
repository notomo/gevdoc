
function! gevdoc#model#doc#new(plugin_path, options) abort
    let plugin_path = fnamemodify(a:plugin_path, ':p')
    let name = fnamemodify(plugin_path, ':h:t')
    let file_path = plugin_path . 'doc/' . name . '.txt'

    let excluded_pattern = join(a:options['exclude'], '\|\m')

    let doc = {
        \ 'name': name,
        \ 'plugin_path': plugin_path,
        \ 'file_path': file_path,
        \ 'textwidth': 78,
        \ 'excluded_pattern': excluded_pattern,
    \ }

    function! doc.lines() abort
        let sep = self.separater()
        return
            \ self.header() +
            \ sep +
            \ self.body(sep) +
            \ self.footer()
    endfunction

    function! doc.header() abort
        let first_line = printf('*%s*', fnamemodify(self.file_path, ':t'))
        return [first_line]
    endfunction

    function! doc.body(sep) abort
        let lines = []
        for chapter in gevdoc#model#chapter#all(self.plugin_path, self.name, self.textwidth, self.excluded_pattern)
            let lines += chapter.lines() + a:sep
        endfor
        return lines
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
