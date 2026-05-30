; extends

((script_element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_coffee)))
  (raw_text) @injection.content)
  (#eq? @_lang "lang")
  (#eq? @_coffee "coffee")
  (#set! injection.language "coffeescript"))
