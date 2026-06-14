; Foldable constructs. Reliable now that blocks and multi-statement bodies
; parse as proper nodes rather than landing in error-recovery.

[
  (function_definition)
  (function_expression)
  (method_definition)
  (class_property_method)
  (class_property_block)
  (class_definition)
  (if_statement)
  (unless_statement)
  (switch_statement)
  (when_clause)
  (for_statement)
  (while_statement)
  (until_statement)
  (loop_statement)
  (try_statement)
  (catch_clause)
  (finally_clause)
  (object)
  (implicit_object)
  (array)
  (do_block)
] @fold
