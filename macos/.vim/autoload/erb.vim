unlet b:current_syntax
syntax include @Ruby syntax/ruby.vim
syntax region RubyC start="<%"  end="%>" oneline contains=@Ruby
syntax region erbSnip start="<<-ERB"  end="ERB" oneline contains=@Ruby


syntax include @SQL syntax/sql.vim
syntax region sqlSnip matchgroup=Snip start="<<-SQL" end="SQL" contains=@SQL
hi link Snip SpecialComment
