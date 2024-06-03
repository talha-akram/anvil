local set_keymap = vim.keymap.set
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local KNOWN_FILE_PATHS = {}
local REGISTERED_FILETYPES = {}
local options = { expr = true, silent = true, noremap = true }
local custom_snippet_dir = vim.fn.stdpath('config') .. '/snippets/'
local friendly_snippets = vim.fn.stdpath('data') .. '/lazy/friendly-snippets/'

local import_json = function(path)
  if vim.fn.filereadable(path) == 0 then
    return {}
  end

  local file = io.open(path, 'r')
  if file then
    local content = file:read('*all')
    file:close()
    return vim.json.decode(content)
  end
end

-- Load friendly snippets metadata
-- parse json into a table where each language is paired with its paths
-- { json = {'./some/json.json', 'other/json.json'} }
local available_snippets = import_json(friendly_snippets .. 'package.json')

if available_snippets.contributes and available_snippets.contributes.snippets then
  local paths = available_snippets.contributes.snippets
  for _i, data in ipairs(paths) do
    local path = friendly_snippets .. string.sub(data.path, 3)
    if type(data.language) == 'table' then
      for _i, lang in ipairs(data.language) do
        if KNOWN_FILE_PATHS[lang] == nil then
          KNOWN_FILE_PATHS[lang] = {path}
        else
          table.insert(KNOWN_FILE_PATHS[lang], path)
        end
      end
    else
      if KNOWN_FILE_PATHS[data.language] == nil then
        KNOWN_FILE_PATHS[data.language] = {path}
      else
        table.insert(KNOWN_FILE_PATHS[data.language], path)
      end
    end
  end
end


local SNIPPET_REPO = setmetatable({}, {
  __index  = function(cache, filetype)
    local snippet_data = {}
    local completion_list = {}
    local custom_snippets = custom_snippet_dir .. filetype .. '.json'

    for _i, path in ipairs(KNOWN_FILE_PATHS[filetype]) do
      vim.tbl_extend('force', snippet_data, import_json(path))
    end

    vim.tbl_extend('force', snippet_data, import_json(custom_snippets))

    for name, snippet in pairs(snippet_data) do
      table.insert(completion_list, to_completion(name, snippet))
    end

    cache[filetype] = completion_list

    return completion_list
  end
})

local get_snippets = function(filetypes)
  local snippets = {}
  for i, filetype in ipairs(filetypes) do
    table.insert(snippets, SNIPPET_REPO[filetype])
  end

  return snippets
end

local extend_filetype = function(filetype, extensions)
  local snippets = {}
  snippets = vim.tbl_extend('force', snippets, SNIPPET_REPO[filetype])

  for _i, extension in ipairs(extensions) do
    snippets = vim.tbl_extend('force', snippets, SNIPPET_REPO[extension])
  end

  REGISTERED_FILETYPES[filetype] = snippets
end

local to_completion = function(name, snippet)
  local body = table.concat(snippet.body, '\n')
  return {
    word      = snippet.prefix,
    menu      = name,
    info      = vim.trim(table.concat({ snippet.description or "", "", body }), '\n'),
    dup       = true,
    user_data = { type = 'snippet', value = body }
  }
end

local snippet_filter = function(line_to_cursor, base)
  return function(s)
    return not s.hidden and vim.startswith(s.trigger, base) and s.show_condition(line_to_cursor)
  end
end

-- Set 'completefunc' or 'omnifunc' to 'v:lua.completefunc' to get snippet completion.
function completefunc(findstart, base)
  local line, col = vim.api.nvim_get_current_line(), vim.api.nvim_win_get_cursor(0)[2]
  local line_to_cursor = line:sub(1, col)

  if findstart == 1 then
    return vim.fn.match(line_to_cursor, '\\k*$')
  end

  local snippets = REGISTERED_FILETYPES[vim.bo.filetype] or SNIPPET_REPO[vim.bo.filetype]
  if snippets == nil then
    return {}
  end

  snippets = vim.tbl_filter(snippet_filter(line_to_cursor, base), snippets)
  table.sort(snippets, function(s1, s2) return s1.word < s2.word end)

  return snippets
end

-- Use completefunc to select from available snippets
vim.o.completefunc = 'v:lua.completefunc'

-- Expand current snippet
local expand_snippet = augroup('Snippet-expand', { clear = true })
autocmd('CompleteDone', {
  desc = 'Expand competed item as a snippet',
  group = expand_snippet,
  callback = function()
    local item = vim.v.completed_item
    if not item or not item.user_data or not item.user_data ~= '' then
      return
    end

    if item.user_data.type == 'snippet' then
      vim.snippet.expand(item.user_data.value)
    end
  end
})

-- Jump forward if possible
vim.keymap.set({ 'i', 's' }, '<c-k>', function()
  return vim.snippet.active({ direction = 1 }) and vim.snippet.jump(-1)
end, options)

-- Jump backward if possible
vim.keymap.set({ 'i', 's' }, '<c-j>', function()
  return vim.snippet.active({ direction = -1 }) and vim.snippet.jump(-1)
end, options)

-- Exit the current snippet
vim.keymap.set({ 'i', 's' }, '<c-Esc>', function()
  return vim.snippet.stop()
end, options)

return {
  extend_filetype = extend_filetype,
}
