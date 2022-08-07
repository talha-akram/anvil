local api = vim.api
local fn = vim.fn

local state = {
  paused = false,
  command = nil
}

local open_output_window = function(bufnr, width, height)
  local ui = api.nvim_list_uis()[1]

  return api.nvim_open_win(bufnr, 0, {
    relative = 'win',
    width = width,
    height = height,
    col = math.floor(ui.width/2 - width/2),
    row = math.floor(ui.height/2 - height/2),
    style = 'minimal',
    border = 'solid'
  })
end

local create_buffer = function()
  local bufnr = api.nvim_create_buf(false, true)
  local set_keymap = vim.keymap.set

  set_keymap('n', 'q', '<cmd>bdelete!<CR>', { noremap = true, buffer = bufnr })
  set_keymap('n', 'p', function() state.pause = true end, { noremap = true, buffer = bufnr })
  set_keymap('n', '<Esc>', '<cmd>bdelete!<CR>', { noremap = true, buffer = bufnr })

  return bufnr
end

local create_post_cmd = function(pattern, command)
  api.nvim_create_autocmd('BufWritePost', {
    group = api.nvim_create_augroup('OnSave', { clear = true }),
    pattern = pattern,
    callback = function()
      if state.paused then
        return
      end

      local bufnr = create_buffer()
      local append_data = function(_, data)
        if data then
          api.nvim_buf_set_lines(bufnr, -1, -1, false, data)
        end
      end

      api.nvim_buf_set_lines(bufnr, 0, -1, false, {'command: ' .. state.command, 'output:'})
      local win = open_output_window(bufnr, 80, 30)

      fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

api.nvim_create_user_command('OnSave', function(opts)
  if opts.args == 'set' then
    local pattern = fn.input('Pattern: ')
    state.command = fn.input('Command: ')

    create_post_cmd(pattern, vim.split(state.command, ' '))
  elseif opts.args == 'pause' then
    state.paused = true
  elseif opts.args == 'resume' then
    state.paused = false
  elseif opts.args == 'clear' then
    state.paused = false
    state.command = nil
   api.nvim_create_augroup('OnSave', { clear = true })
  else
    print('Invalid argument: ', opts.args)
  end
end, {
  complete = function(arg)
    local options = {'set', 'pause', 'resume', 'clear'}

    table.sort(options, function(a, b)
      local a_loc = string.find(a, arg)
      local b_loc = string.find(b, arg)

      if a_loc == nil and b_loc == nil then
        return false
      elseif a_loc ~= nil and b_loc ~= nil then
        return a_loc < b_loc
      elseif a_loc == nil then
        return false
      end

      return true
    end)
    return options
  end, nargs = 1
})
