; Inject HTML inside triple-backtick fences (with optional language tag)
((embedded_html) @injection.content
  (#match? @injection.content "^```html")
  (#set! injection.language "html")
  (#offset! @injection.content 0 7 0 -3))

((embedded_html) @injection.content
  (#match? @injection.content "^```\\r?\\n")
  (#set! injection.language "html")
  (#offset! @injection.content 0 3 0 -3))

; Treat heredoc strings that look like HTML as HTML blocks
((heredoc_string) @injection.content
  (#match? @injection.content "^'''[\\s\\S]*<")
  (#set! injection.language "html")
  (#offset! @injection.content 0 3 0 -3))

((heredoc_string) @injection.content
  (#match? @injection.content "^\"\"\"[\\s\\S]*<")
  (#set! injection.language "html")
  (#offset! @injection.content 0 3 0 -3))
