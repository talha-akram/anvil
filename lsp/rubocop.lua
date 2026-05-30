return {
  cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
  filetypes = { 'ruby', 'eruby' },
  root_markers = { '.rubocop.yml', 'Gemfile', '.git' },
}
