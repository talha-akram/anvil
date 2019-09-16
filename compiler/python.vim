if exists("current_compiler")
  finish
endif
let current_compiler = "python"

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=python\ -m\ unittest

"the last line: \%-G%.%# is meant to suppress some
"late error messages that could occur and prevent
"one from using :clast to go to the relevant file
"and line of the traceback.
CompilerSet errorformat=
    \%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
    \%C\ \ \ \ %.%#,
    \%+Z%.%#Error\:\ %.%#,
    \%A\ \ File\ \"%f\"\\\,\ line\ %l,
    \%+C\ \ %.%#,
    \%-C%p^,
    \%Z%m,
    \%-G%.%#

" CompilerSet errorformat=
"       \%*\\sFile\ \"%f\"\\,\ line\ %l\\,\ %m,
"       \%*\\sFile\ \"%f\"\\,\ line\ %l,

let &cpo = s:cpo_save
unlet s:cpo_save
