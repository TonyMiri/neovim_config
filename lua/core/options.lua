vim.wo.number = true --Line numbers visible
vim.o.relativenumber = true --Relative line numbers
vim.o.clipboard = 'unnamedplus' -- Sync clipboard with OS and neovim
vim.o.wrap = false -- Display lines as one long line
vim.o.linebreak = true -- Companion to wrap, don't split words
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.autoindent = true
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true -- Smart case
vim.o.shiftwidth = 4 -- Number of spaces inserted for each indentation
vim.o.tabstop = 4 -- Insert n spaces for a tab
vim.o.softtabstop = 4 -- Number of spaces that a tab counts for while performing editing operations
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.scrolloff = 4 -- Minimal number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is 'false'
vim.o.cursorline = false -- Highlight the current line
vim.o.splitbelow = true -- Force all horizontal splits to go below current window
vim.o.splitright = true -- Force all vertical splits to go to the right of current window
vim.o.hlsearch = false -- Set highlight on search
vim.o.showmode = false -- Don't show -- INSERT -- etc... at bottom of screen
vim.opt.termguicolors = true -- Set termguicolors to enable highlight groups
vim.o.whichwrap = 'bs<>[]hl' -- Which 'horizontal' keys are allowed to travel to prev/next line
vim.o.numberwidth = 4 -- Set number column width to 2
vim.o.swapfile = false -- Creates a swapfile
vim.o.smartindent = true -- Make indenting smarter again
vim.o.showtabline = 2 -- Always show tabs
vim.o.backspace = 'indent,eol,start' -- Allow backspace on
vim.o.pumheight = 10 -- Pop up menu height
vim.o.conceallevel = 0 -- So that `` is visible in markdown files
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.fileencoding = 'utf-8' -- Default encoding
vim.o.cmdheight = 1 -- More space in the neovim command line for displaying messages
vim.o.breakindent = true -- Enable break indent
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Time to wait for a mapped sequence to complete
vim.o.backup = false -- Creates a backup file
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.o.undofile = true -- Save undo history
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.opt.shortmess:append 'c' -- Don't give |ins-completion-menu| messages
vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches
vim.opt.formatoptions:remove {'c', 'r', 'o' } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'o' in normal mode.
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles' -- Separate vim plugins from Neovim in case Vim still in use
