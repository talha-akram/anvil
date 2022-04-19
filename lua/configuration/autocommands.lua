-- Auto commands use sparingly, having auto commands that trigger often may
-- slow down nvim
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd


return {
  setup = function()
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
      desc = "LOL",
      pattern="help",
      command = "wincmd L",
      group = vertical_help
    })
  end
}
