local fn = vim.fn
local global_options = vim.o

local defined_options  = {
  -- Prefer dark background
  background     = "dark",
  -- Set fish as default shell
  shell          = "fish",
  -- Dissable modelines
  modeline       = false,
  -- Restrict existing tab to width of 4 spaces
  tabstop        = 2,
  -- Use 4 spaces for tabs
  shiftwidth     = 2,
  -- Always expand tabs to spaces
  expandtab      = true,
  -- Show line numders
  number         = true,
  -- Highlight line containing the cursor
  cursorline     = true,
  -- But only the visual line, not the complete physical line
  -- cursorlineopt  = "screenline",
  -- Enable mouse interaction
  mouse          = "nvi",
  -- Use English dictionary
  spelllang      = "en_gb",
  -- Hide buffers with unsaved changes without being prompted
  hidden         = true,
  -- Auto-complete on tab, while in command mode
  wildmenu       = true,
  -- Ignore case when completing in command mode
  wildignorecase = true,
  -- Donot use popup menu for completions in command mode
  wildoptions    = "tagfile",
  -- Auto select the first entry but don"t insert
  completeopt    ="noinsert,menuone,preview",
  -- Stop popup menu messages
  shortmess      = "filnxtToOFc",
  -- Use interactive replace
  inccommand     = "split",
  -- Use interactive search
  incsearch      = true,
  -- Don"t update screen while macro or command/script is executing
  lazyredraw     = true,
  -- Use global status line
  laststatus     = 3,
  -- Don"t show mode as it is already displayrd in status line
  showmode       = false,
  -- Show sign column inside the number column
  signcolumn     = "auto",
  -- Minimum number of lines to keep before scrolling
  scrolloff      = 6,
  -- Max number of items visible in popup menu
  pumheight      = 12,
  -- Trigger CursorHold event if nothing is typed for the duration
  updatetime     = 1000,
  -- Settings for better diffs
  diffopt        = "filler,vertical,hiddenoff,foldcolumn:0,algorithm:patience",
  -- Show whitespace characters
  list           = true,
  -- Only show tabs and trailing spaces
  listchars      = "tab:▶-,trail:●,extends:◣,precedes:◢",
  -- Default search is not case sensitive
  ignorecase     = true,
  -- Search will be case sensitive if uppercase character is entered
  smartcase      = true,
  -- Automatically Read changes made to file outside of Vim
  autoread       = true,
  -- Don"t wrap long lines
  wrap           = false,
  -- Tell neovim where to look for tags file
  tags           = "/tmp/tags",
  -- Number of columns to scroll horizontally when cursor is moved off the screen
  sidescroll     = 5,
  -- Minimum number of columns to keep towards the right of the cursor
  sidescrolloff  = 5,
  -- Keep folds open by default, they can easily be closed using "zM"
  foldenable     = false,
}

-- Enable true colors if supported
if (fn.has("termguicolors")) then
  defined_options.termguicolors = true
end

-- Undo file settings
if (fn.has("persistent_undo")) then
    defined_options.undodir     = fn.stdpath("config") .. "/undodir/"
    defined_options.undofile    = true
end

-- Dissable some features when running as Root
if (fn.exists("$SUDO_USER") ~= 0) then
    defined_options.swapfile    = false
    defined_options.backup      = false
    defined_options.writebackup = false
    defined_options.undofile    = false
    defined_options.viminfo     = nil
end

-- Use ripgrep as the grep program, if available
if (fn.executable("rg")) then
    defined_options.grepprg     = "rg --vimgrep --no-heading --smart-case"
end

local Options = {
  defined = defined_options,
  setup = function()
    for option, value in pairs(defined_options) do
      global_options[option] = value
    end

    -- Enable filetype detection and use plugins and indentation
    vim.cmd("filetype plugin indent on")

    -- Enable highlighting embedded lua code
    vim.g.vimsyn_embed      = "l"
    -- Use Python 3 for plugins
    vim.g.python3_host_prog = "python3"
  end
}


return Options

