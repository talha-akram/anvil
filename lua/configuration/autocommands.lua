-- Auto commands use sparingly, having auto commands that trigger often may
-- slow down nvim
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd


-- Highlight current line on active window only
local active_line_highligh = augroup("HighlightActiveLine", { clear = true })
autocmd("WinEnter", {
  desc = "show cursorline",
  callback = function() vim.wo.cursorline = true end,
  group = active_line_highligh
})
autocmd("WinLeave", {
  desc = "hide cursorline",
  callback = function() vim.wo.cursorline = false end,
  group = active_line_highligh
})

-- Use vertical splits for help windows
local vertical_help = augroup("VerticalHelp", { clear = true })
autocmd("FileType", {
  desc = "make help split vertical",
  pattern="help",
  command = "wincmd L",
  group = vertical_help
})

-- Highlight yanked text
local vertical_help = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  desc = "highlight yanked text",
  callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 50 }) end,
  group = vertical_help
})

