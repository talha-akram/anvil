; CoffeeScript highlights
;
; Tree-sitter applies the LAST matching pattern for a given node, so order
; matters: the generic `(identifier) @variable` fallback comes first and the
; more specific identifier roles (functions, members, parameters, types) come
; after so they win.

; --- Fallback ---------------------------------------------------------------

(identifier) @variable

; --- Members & properties ---------------------------------------------------

; obj.prop  ->  prop is a member access
(member_expression
  (identifier) @variable.member)

(existential_member_expression
  (identifier) @variable.member)

; @foo  ->  the @ is `this`, foo is a member
(instance_variable
  (identifier) @variable.member)

; { key: value }  ->  key is a property (also matches `{ a, b }` shorthand)
(pair
  (identifier) @property)

(object_pattern
  (identifier) @variable.member)

; --- Parameters -------------------------------------------------------------

(parameters
  (parameter
    (pattern (identifier) @variable.parameter)))

(parameters
  (parameter
    (pattern (instance_variable (identifier) @variable.parameter))))

(function_expression
  (pattern (identifier) @variable.parameter))

(function_expression
  (pattern (instance_variable (identifier) @variable.parameter)))

(splat_pattern (identifier) @variable.parameter)

; catch err  ->  the bound error is a parameter-like binding
(catch_clause
  (identifier) @variable.parameter)

; --- Functions & methods ----------------------------------------------------

(function_definition
  (identifier) @function)

(method_definition
  (identifier) @function.method)

(class_property_method
  (identifier) @function.method)

; bare call:  foo()
(function_call
  (expression (identifier) @function.call))

(existential_function_call
  (expression (identifier) @function.call))

; implicit (paren-less) call:  foo a, b   (callee is the first child only)
(implicit_call
  .
  (expression (identifier) @function.call))

; implicit method call:  console.log msg
(implicit_call
  .
  (expression
    (member_expression
      (identifier) @function.method.call)))

; method call:  obj.bar()  (wins over the member rule above)
(function_call
  (expression
    (member_expression
      (identifier) @function.method.call)))

(existential_function_call
  (expression
    (existential_member_expression
      (identifier) @function.method.call)))

; --- Classes & constructors -------------------------------------------------

(class_definition
  (identifier) @type)

(class_definition
  "extends"
  (identifier) @type)

; new Foo  /  new Foo()
(new_expression
  (expression (identifier) @constructor))

(new_expression
  (expression
    (function_call
      (expression (identifier) @constructor))))

; --- Literals ---------------------------------------------------------------

(number) @number
(boolean) @boolean
(null_literal) @constant.builtin
(undefined_literal) @constant.builtin

; Strings: capture the content pieces (not the whole node) so interpolated
; expressions inside `#{ ... }` keep their own code highlighting.
(single_quoted_content) @string
(double_quoted_content) @string
(escape_sequence) @string.escape

[
  "'"
  "\""
  "'''"
  "\"\"\""
] @string

(regex) @string.regexp

; --- Interpolation ----------------------------------------------------------

(interpolation
  "#{" @punctuation.special)

(interpolation
  "}" @punctuation.special)

; --- this / super -----------------------------------------------------------

"@" @variable.builtin
"super" @variable.builtin
[ "module" "exports" ] @variable.builtin

; --- Keywords ---------------------------------------------------------------

[
  "if"
  "else"
  "else if"
  "unless"
  "then"
  "switch"
  "when"
] @keyword.conditional

[
  "for"
  "while"
  "until"
  "loop"
  "do"
  "by"
  "own"
] @keyword.repeat

[
  "try"
  "catch"
  "finally"
  "throw"
] @keyword.exception

"return" @keyword.return
(break_statement) @keyword
(continue_statement) @keyword

[
  "import"
  "export"
  "from"
  "as"
  "default"
] @keyword.import

[
  "await"
  "async"
  "yield"
] @keyword.coroutine

[
  "and"
  "or"
  "not"
  "is"
  "isnt"
  "in"
  "of"
  "instanceof"
  "new"
  "typeof"
  "delete"
] @keyword.operator

[
  "class"
  "extends"
  "var"
] @keyword

; Function arrows
[
  "->"
  "=>"
] @keyword.function

; --- Operators --------------------------------------------------------------

[
  "="
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  "+"
  "-"
  "*"
  "/"
  "%"
  "%%"
  "&"
  "|"
  "^"
  "~"
  "<<"
  ">>"
  ">>>"
  "&&"
  "||"
  "!"
  "+="
  "-="
  "*="
  "/="
  "%="
  "?="
  "&&="
  "||="
  "?"
  "?."
  "::"
  ".."
  "..."
] @operator

; --- Punctuation ------------------------------------------------------------

[ "(" ")" "[" "]" "{" "}" ] @punctuation.bracket
[ "," ";" ":" "." ] @punctuation.delimiter

; Embedded-code fences (` ... ` JavaScript, ``` ... ``` HTML) frame injections.
[ "`" "```" ] @punctuation.special

; --- JSX (light support) ----------------------------------------------------

(jsx_element
  (identifier) @tag)

(jsx_attribute
  (identifier) @tag.attribute)

[ "<" ">" "</" "/>" ] @tag.delimiter

; --- Comments (last, so nothing overrides them) -----------------------------

(comment) @comment @spell
