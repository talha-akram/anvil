-- Remove quickfix item under cursor from list
vim.keymap.set('n', 'dd', function()
  local curqfidx = vim.fn.line('.')
  local qfall = vim.fn.getqflist()

  -- Return if there are no items to remove
  if #qfall == 0 then return end

  -- Remove the item from the quickfix list
  table.remove(qfall, curqfidx)
  vim.fn.setqflist(qfall, 'r')

  -- Reopen quickfix window to refresh the list
  vim.cmd('copen')

  -- If not at the end of the list, stay at the same index, otherwise, go one up.
  local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)

  -- Set the cursor position directly in the quickfix window
  local winid = vim.fn.win_getid() -- Get the window ID of the quickfix window
  vim.api.nvim_win_set_cursor(winid, {new_idx, 0})
end, {buffer = true})

vim.keymap.set('x', 'd', function()
  local qf_list = vim.fn.getqflist()

  -- Get selected range in visual mode
  local starts = vim.fn.line('v')
  local ends = vim.fn.line('.')
  local from = math.min(starts, ends)
  local to = math.max(starts, ends)

  -- Remove entries from the quickfix list
  for index = from, to, 1 do
    table.remove(qf_list, index)
    log_to_file(string.format("removed: %s", index))
  end

  -- Replace the quickfix list with the updated list
  vim.fn.setqflist(qf_list, "r")

  -- Refresh the quickfix window
  vim.cmd("copen")
end, {buffer = true})
