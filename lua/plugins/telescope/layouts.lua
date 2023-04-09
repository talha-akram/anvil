local themes = {
  popup_list = {
    theme = 'popup_list',
    previewer = false,
    prompt_title = false,
    results_title = false,
    sorting_strategy = 'ascending',
    layout_strategy = 'center',
    layout_config = {
      width = 0.5,
      height = 0.3,
      mirror = true,
      preview_cutoff = 1,
    },
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┤', '└' },
      results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
  },
  popup_extended = {
    theme = 'popup_extended',
    prompt_title = false,
    results_title = false,
    layout_strategy = 'center',
    layout_config = {
      width = 0.5,
      height = 0.3,
      mirror = true,
      preview_cutoff = 1,
    },
    borderchars = {
      prompt  = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
      preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
    },
  },
  command_pane = {
    theme = 'command_pane',
    previewer = false,
    prompt_title = false,
    results_title = false,
    sorting_strategy = 'descending',
    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 13,
      preview_cutoff = 1,
      prompt_position = 'bottom'
    },
  },
  ivy_plus = {
    theme = 'ivy_plus',
    previewer = false,
    prompt_title = false,
    results_title = false,
    layout_strategy = 'bottom_pane',
    layout_config = {
      height = 13,
      preview_cutoff = 120,
      prompt_position = 'bottom'
    },
    borderchars = {
      prompt  = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
      results = { '─', '│', '─', '│', '┌', '┬', '┴', '└' },
      preview = { '─', '│', ' ', ' ', '─', '┐', '│', ' ' },
    },
  },
}

return function(picker, layout)
  return function() picker(themes[layout]) end
end
