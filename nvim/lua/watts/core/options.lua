-- for conciseness
local api = vim.api
local cmd = vim.cmd
local opt = vim.opt

-- Disable swap file
-- https://neovim.io/doc/user/recover.html#swap-file
-- I haven't used a swap file in many years - and when it's existed,
-- say with a config that I haven't turned it off,
-- it always seems to get in the way.
--
-- I'm open to changing this in the future, but as for right now - I'm not worried about it.
opt.swapfile = false

-- Write the current contents of the file on context switch
-- https://neovim.io/doc/user/options.html#'autowrite'
opt.autowrite = true

-- line numbers
opt.number = true         -- turn on line numbers
opt.relativenumber = true -- make line numbers releative to the cursor

-- tabs & indentation
-- https://neovim.io/doc/user/usr_25.html#25.3
--
-- When a new line is started it gets the same indent as the previous line.
opt.autoindent = true
-- Always use spaces, instead of the tab character, when hitting <Tab>
opt.expandtab = true
-- Make an indent a multiple of 2
opt.shiftwidth = 2
-- Make <Tab> use 2 spaces worth of indent
opt.softtabstop = 2
-- Make <Tab> use 2 spaces worth of indent, regardless what the tabstop was for the file (AFAIK, converts it)
opt.tabstop = 2

-- Disable line wrapping
opt.wrap = false

-- Search settings
-- https://neovim.io/doc/user/pattern.html#%2Fignorecase
-- If the 'ignorecase' option is on, the case of normal letters is ignored.
-- 'smartcase' can be set to ignore case when the pattern contains lowercase
-- letters only.
opt.ignorecase = true
opt.smartcase = true

-- Appearance
--
-- https://neovim.io/doc/user/options.html#'cursorline'
-- Highlight the text line of the cursor with CursorLine hl-CursorLine.
-- Useful to easily spot the cursor.  Will make screen redrawing slower.
-- When Visual mode is active the highlighting isn't used to make it
-- easier to see the selected text.
opt.cursorline = true
-- https://neovim.io/doc/user/options.html#'termguicolors'
-- Enables 24-bit RGB color
opt.termguicolors = true
-- Set background color as dark
opt.background = "dark"
-- Always display the left sign-column, regardless of whether or not data is injected there.
-- an example here is gitgutter. When using gitgutter, and there aren't any changes to the file,
-- gitgutter doesn't add anything to the sign column. As soon as there is a change, values will be added, and
-- the screen will shift to accomodate the signs.
--
-- Setting this to "yes" means it'll always make space - therefore no shifting.
opt.signcolumn = "yes"

-- Add the machine clipboard as the clipboard, so that items that are yanked will
-- be available for pasting elsewhere in the system.
opt.clipboard:append("unnamedplus")

-- Fixing backspace
-- https://neovim.io/doc/user/options.html#'backspace'
--
-- This is really to enable the Backspace key to work as expected in any other application.
-- I can't remember why the backspace doesn't just work out of the box... but here we are.
opt.backspace = "indent,eol,start"

-- Window Splitting
-- When doing a vertical split, send the split to the right
opt.splitright = true
-- When doing a horizontal split, send the split to the bottom half
opt.splitbelow = true

-- Scrolling
-- Start scrolling three lines from the bottom
opt.scrolloff = 3
-- Start scrolling 6 lines from the right
opt.sidescrolloff = 6

-- Words
-- Include dashes as part of the word, when traversing with `w`
opt.iskeyword:append("-")

-- Screen Refreshing / Drawing
-- When this option is set, the screen will not be redrawn while
-- executing macros, registers and other commands that have not been
-- typed.  Also, updating the window title is postponed.
--
-- This is set to false, re: Noice plugin
opt.lazyredraw = false
