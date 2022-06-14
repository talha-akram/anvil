-- Setup nvim-comment
return require('nvim_comment').setup({
  marker_padding = true,
  comment_empty = false,
  comment_empty_trim_whitespace = true,
  create_mappings = true,
  line_mapping = 'gcc',
  operator_mapping = 'gc',
  comment_chunk_text_object = 'ic',
  hook = function()
    require("ts_context_commentstring.internal").update_commentstring()
  end
})

