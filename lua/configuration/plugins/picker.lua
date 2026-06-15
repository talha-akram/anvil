-- Fuzzy selection for files and more, see plugin settings for keymaps.
local map = vim.keymap.set
local highlight = vim.api.nvim_set_hl

highlight(0, 'MiniPickBorder',        { link='Pmenu' })
highlight(0, 'MiniPickBorderBusy',    { link='Pmenu' })
highlight(0, 'MiniPickBorderText',    { link='Pmenu' })
highlight(0, 'MiniPickIconDirectory', { link='Pmenu' })
highlight(0, 'MiniPickIconFile',      { link='Pmenu' })
highlight(0, 'MiniPickNormal',        { link='Pmenu' })
highlight(0, 'MiniPickHeader',        { link='Title' })
highlight(0, 'MiniPickMatchCurrent',  { link='PmenuThumb' })
highlight(0, 'MiniPickMatchMarked',   { link='FloatTitle' })
highlight(0, 'MiniPickMatchRanges',   { link='FloatTitle' })
highlight(0, 'MiniPickPreviewLine',   { link='CursorLine' })
highlight(0, 'MiniPickPreviewRegion', { link='PmenuThumb' })
highlight(0, 'MiniPickPrompt',        { link='Pmenu' })

local set_keymap = function(lhs, rhs, mode)
  map(mode or 'n', lhs, rhs, { noremap = true })
end

local short_path = function(path)
  return vim.startswith(path, cwd) and path:sub(cwd:len() + 1) or vim.fn.fnamemodify(path, ':~')
end

local pickers =  {
  registry = function()
    local picker = require('mini.pick')
    local selected = picker.start({
      source = { items = vim.tbl_keys(picker.registry), name = 'Registry' }
    })

    if selected == nil then return end

    return picker.registry[selected]()
  end,
  git_status = function()
    local pick = require('mini.pick')
    local ns = vim.api.nvim_create_namespace('MiniPickGitStatus')

    local status_path = function(item)
      local path = vim.trim(item:sub(4))
      path = path:match('%-> (.+)$') or path
      if path:sub(1, 1) == '"' then path = path:sub(2, -2) end
      return path
    end

    local run = function(cmd, done)
      local out = {}
      vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data) if data then out = data end end,
        on_exit = function()
          if out[#out] == '' then table.remove(out) end
          vim.schedule(function() done(out) end)
        end,
      })
    end

    local set_content = function(bufnr, path, lines)
      vim.bo[bufnr].modifiable = true
      vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      vim.bo[bufnr].modifiable = false
      pcall(vim.api.nvim_buf_clear_namespace, bufnr, ns, 0, -1)
      vim.bo[bufnr].filetype = vim.filetype.match({ filename = path, buf = bufnr }) or ''
    end

    local highlight_all = function(bufnr, group)
      for row = 0, vim.api.nvim_buf_line_count(bufnr) - 1 do
        vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, { line_hl_group = group })
      end
    end

    local apply_diff = function(bufnr, diff)
      local total = vim.api.nvim_buf_line_count(bufnr)
      local lnum, removed = nil, {}

      local flush = function(at)
        if #removed == 0 then return end
        local virt = {}
        for _, text in ipairs(removed) do virt[#virt + 1] = { { text, 'DiffDelete' } } end
        removed = {}
        local row = (at or total + 1) - 1
        if row >= total then
          vim.api.nvim_buf_set_extmark(bufnr, ns, total - 1, 0, { virt_lines = virt })
        else
          vim.api.nvim_buf_set_extmark(bufnr, ns, math.max(row, 0), 0, {
            virt_lines = virt, virt_lines_above = true
          })
        end
      end

      for _, line in ipairs(diff) do
        local start = line:match('^@@ %-%d+,?%d* %+(%d+)')
        if start then
          flush(lnum)
          lnum = tonumber(start)
        elseif lnum then
          local tag = line:sub(1, 1)
          if tag == '+' then
            flush(lnum)
            if lnum >= 1 and lnum <= total then
              vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, 0, { line_hl_group = 'DiffAdd' })
            end
            lnum = lnum + 1
          elseif tag == '-' then
            removed[#removed + 1] = line:sub(2)
          elseif tag ~= '\\' then
            flush(lnum)
            lnum = lnum + 1
          end
        end
      end
      flush(lnum)
    end

    pick.builtin.cli({
      command = {
        'git', 'status', '--short'
      }
    }, {
      source = {
        name = 'Git Status',
        preview = function(bufnr, item)
          local path = status_path(item)
          vim.b[bufnr].git_preview = path
          local fresh = function()
            return vim.api.nvim_buf_is_valid(bufnr) and vim.b[bufnr].git_preview == path
          end

          if vim.fn.filereadable(path) == 0 then
            run({ 'git', 'show', 'HEAD:./' .. path }, function(content)
              if not fresh() then return end
              set_content(bufnr, path, content)
              highlight_all(bufnr, 'DiffDelete')
            end)
            return
          end

          set_content(bufnr, path, vim.fn.readfile(path))

          -- Untracked: nothing to diff against
          if item:sub(1, 2) == '??' then
            highlight_all(bufnr, 'DiffAdd')
            return
          end

          run({ 'git', 'diff', 'HEAD', '--', path }, function(diff)
            if not fresh() then return end
            apply_diff(bufnr, diff)
          end)
        end,
        choose = function(item)
          local path = status_path(item)
          vim.schedule(function() vim.cmd.edit(vim.fn.fnameescape(path)) end)
        end
      }
    })
  end,
  find = function()
    local register = vim.fn.getreg('"')
    local cursor = vim.api.nvim_win_get_cursor(0)
    local view = vim.fn.winsaveview()

    vim.cmd([[normal! "xy]])

    local selection = vim.fn.getreg('"')

    vim.fn.setreg('"', register)
    vim.fn.winrestview(view)
    vim.api.nvim_win_set_cursor(0, cursor)

    require('mini.pick').builtin.grep(
      { pattern = selection },
      { source = { name = string.format('Grep "%s"', selection) } }
    )
  end,
  all_files = function()
    require('mini.pick').builtin.cli({
      command = {
        'fd',
        '--type',
        'f',
        '--no-ignore',
        '--hidden',
        '--follow',
        '--exclude',
        '.git',
        '--exclude',
        'node_modules',
        '--exclude',
        'build',
        '--exclude',
        'tmp',
      }
    }, {
      source = {
        name = 'All Files',
      }
    })
  end,
  quickfix = function()
    require('mini.pick').start({
      source = {
        items = vim.fn.getqflist(),
        name = 'Quickfix List'
      }
    })
  end,
  loclist = function()
    require('mini.pick').start({
      source = {
        items = vim.fn.getloclist(0),
        name = 'Location List'
      }
    })
  end,
  oldfiles = function()
    local items = {}
    local cwd = vim.fn.getcwd()
    -- Ensure cwd has a trailing slash
    cwd = cwd:sub(-1) == '/' and cwd or (cwd .. '/')

    for _, path in ipairs(vim.v.oldfiles) do
      local normal_path = nil
      if vim.startswith(path, cwd) then
        -- Use ./ as cwd prefix
        normal_path = '.'.. path:sub(cwd:len())
      else
        -- Use ~ as home directory prefix
        normal_path = vim.fn.fnamemodify(path, ':~')
      end

      table.insert(items, normal_path)
    end

    local selection = require('mini.pick').start({
      source = {
        items = items,
        name = 'Recent Files'
      }
    })

    if selection then
      vim.cmd.edit(vim.trim(selection):match('%s+(.+)'))
    end
  end,
  hl_groups = function()
    local pick = require('mini.pick')
    local ns_id = vim.api.nvim_create_namespace('MiniExtraPickers')

    -- Construct items
    local group_data = vim.split(vim.api.nvim_exec('highlight', true), '\n')
    local items = {}
    for _, l in ipairs(group_data) do
      local group = l:match('^(%S+)')
      if group ~= nil then table.insert(items, group) end
    end

    local show = function(buf_id, items_to_show, query)
      vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, items_to_show)
      pcall(vim.api.nvim_buf_clear_namespace, buf_id, ns_id, 0, -1)
      -- Highlight line with highlight group of its item
      for i = 1, #items_to_show do
        local opts = { end_row = i, end_col = 0, hl_mode = 'blend', hl_group = items_to_show[i], priority = 300 }
        vim.api.nvim_buf_set_extmark(buf_id, ns_id, i - 1, 0, opts)
      end
    end

    -- Define source
    local preview = function(buf_id, item)
      local lines = vim.split(vim.api.nvim_exec('hi ' .. item, true), '\n')
      vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
    end

    local choose = function(item)
      local hl_def = vim.split(vim.api.nvim_exec('hi ' .. item, true), '\n')[1]
      hl_def = hl_def:gsub('^(%S+)%s+xxx%s+', '%1 ')
      vim.schedule(function() vim.fn.feedkeys(':hi ' .. hl_def, 'n') end)
    end

    return pick.start({ source = { items = items, name = 'Highlight groups', show = show, preview = preview, choose = choose } })
  end,
}

return {
  src = 'https://github.com/nvim-mini/mini.pick',
  data = {
    setup = function()
      local picker = require('mini.pick')

      -- Add custom pickers to registry
      pickers = vim.tbl_extend('force', pickers, picker.builtin)
      picker.registry = pickers

      -- Bind keys enabling quick access to pickers
      set_keymap('<F1>',      pickers.help)
      set_keymap(',o',        pickers.oldfiles)
      set_keymap('<leader>,', pickers.resume)
      set_keymap('<leader>o', pickers.files)
      set_keymap('<leader>b', pickers.buffers)
      set_keymap('<leader>f', pickers.grep_live)
      set_keymap('<leader>f', pickers.find, 'v')
      set_keymap('<leader>F', pickers.all_files)
      set_keymap('<leader>g', pickers.git_status)
      set_keymap('<leader>p', pickers.registry)
      set_keymap('<leader>q', pickers.quickfix)
      set_keymap('<leader>l', pickers.loclist)

      picker.setup({
        delay = {
          async = 10,
          busy = 30,
        },

        mappings = {
          caret_left        = '<Left>',
          caret_right       = '<Right>',

          choose            = '<CR>',
          choose_in_split   = '<C-s>',
          choose_in_tabpage = '<C-t>',
          choose_in_vsplit  = '<C-v>',
          choose_marked     = '<C-CR>',

          delete_char       = '<BS>',
          delete_char_right = '<S-BS>',
          delete_left       = '<A-BS>',
          delete_word       = '<C-w>',

          mark              = '<C-x>',
          mark_all          = '<C-a>',

          move_start        = '<C-g>',
          move_down         = '<C-n>',
          move_up           = '<C-p>',

          paste             = '<A-p>',

          refine            = '<C-Space>',
          refine_marked     = '<M-Space>',

          scroll_up         = '<C-u>',
          scroll_down       = '<C-d>',
          scroll_left       = '<C-h>',
          scroll_right      = '<C-l>',

          stop              = '<Esc>',

          toggle_info       = '<S-Tab>',
          toggle_preview    = '<Tab>',

          send_to_qflist    = {
            char = '<C-q>',
            func = function()
              local list = {}
              local matches = picker.get_picker_matches().all

              for _, match in ipairs(matches) do
                if type(match) == 'table' then
                  table.insert(list, match)
                else
                  local path, lnum, col, search = string.match(match, '(.-)%z(%d+)%z(%d+)%z%s*(.+)')
                  local text = path and string.format('%s [%s:%s]  %s', path, lnum, col, search)
                  local filename =  path or vim.trim(match):match('%s+(.+)')

                  table.insert(list, {
                    filename = filename or match,
                    lnum = lnum or 1,
                    col = col or 1,
                    text = text or match,
                  })
                end
              end

              vim.fn.setqflist(list, 'r')
            end,
          },
        },

        options = {
          content_from_bottom = false,
          use_cache = false,
        },

        source = {
          items = nil,
          name  = nil,
          cwd   = nil,

          match   = nil,
          preview = nil,
          show    = function(buf_id, items, query, opts)
            picker.default_show(
              buf_id,
              items,
              query,
              vim.tbl_deep_extend('force', { show_icons = false, icons = {} }, opts or {})
            )
          end,

          choose        = nil,
          choose_marked = nil,
        },

        -- Window related options
        window = {
          config = function()
            local height, width, starts, ends
            local win_width = vim.o.columns
            local win_height = vim.o.lines

            if win_height <= 25 then
              height = math.min(win_height, 18)
              width = win_width
              starts = 1
              ends = win_height
            else
              width = math.floor(win_width * 0.5) -- 50%
              height = math.floor(win_height * 0.3) -- 30%
              starts = math.floor((win_width - width) / 2)
              -- center prompt: height * (50% + 30%)
              -- center window: height * [50% + (30% / 2)]
              ends = math.floor(win_height * 0.65)
            end

            return {
              col = starts,
              row = ends,
              height = height,
              width = width,
              style = 'minimal',
              border = { ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' },
            }
          end,

          -- String to use as cursor in prompt
          prompt_caret = '|',

          -- String to use as prefix in prompt
          prompt_prefix = '',
        },
      })
    end,
  }
}
