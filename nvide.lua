--[[

                          oo       dP
                                   88
        88d888b. dP   .dP dP .d888b88 .d8888b.
        88'  `88 88   d8' 88 88'  `88 88ooood8
        88    88 88 .88'  88 88.  .88 88.  ...
        dP    dP 8888P'   dP `88888P8 `88888P'

        NVide Configuration File
        Custom NeoVim setup to emulate Visual Studio Code
        behavior with extended keybindings,
        clipboard integration, fuzzy search,
        and GUI-like UX.

]]--

local Settings = {
  ['Find'] = {
    ['Enabled'] = true,
    ['Shortcut'] = '<C-F>',
  },
  ['Terminal'] = {
    ['Enabled'] = true,
    ['Shortcut'] = '<C-T>',
  },
  ['Sidebar'] = {
    ['Enabled'] = true,
    ['Shortcut'] = '<C-B>',
  },
  ['FindFiles'] = {
    ['Enabled'] = true,
    ['Shortcut'] = '<C-P>',
  },
  ['GoToLine'] = {
    ['Enabled'] = true,
    ['Shortcut'] = '<C-G>',
  },
}

-- Load mswin.vim configuration from VimScript to simulate Windows-like behaviors
-- mswin.vim
vim.cmd [[
	" Set options and add mapping such that Vim behaves a lot like MS-Windows
	"
	" Maintainer:	The Vim Project <https://github.com/vim/vim>
	" Last Change:	2024 Mar 13
	" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
	
	" Bail out if this isn't wanted.
	if exists("g:skip_loading_mswin") && g:skip_loading_mswin
	  finish
	endif
	
	" set the 'cpoptions' to its Vim default
	if 1	" only do this when compiled with expression evaluation
	  let s:save_cpo = &cpoptions
	endif
	set cpo&vim
	
	" set 'selection', 'selectmode', 'mousemodel' and 'keymodel' for MS-Windows
	" behave mswin
	" NVide:
	set selection=exclusive
	set selectmode=mouse,key
	set mousemodel=popup
	set keymodel=startsel,stopsel
	
	" backspace and cursor keys wrap to previous/next line
	set backspace=indent,eol,start whichwrap+=<,>,[,]
	
	" backspace in Visual mode deletes selection
	" NVide: changed 'd' to '"_d'
	vnoremap <BS> "_d
	
	" the better solution would be to use has("clipboard_working"),
	" but that may not be available yet while starting up, so let's just check if
	" clipboard support has been compiled in and assume it will be working :/
	if has("clipboard")
	    " CTRL-X and SHIFT-Del are Cut
	    vnoremap <C-X> "+x
	    vnoremap <S-Del> "+x
	
	    " CTRL-C and CTRL-Insert are Copy
	    vnoremap <C-C> "+y
	    vnoremap <C-Insert> "+y
	
	    " CTRL-V and SHIFT-Insert are Paste
	    map <C-V>		"+gP
	    map <S-Insert>		"+gP
	
	    cmap <C-V>		<C-R>+
	    cmap <S-Insert>		<C-R>+
	else
			" Use the unnamed register when clipboard support not available
	
	    " CTRL-X and SHIFT-Del are Cut
	    vnoremap <C-X>   x
	    vnoremap <S-Del> x
	
	    " CTRL-C and CTRL-Insert are Copy
	    vnoremap <C-C>      y
	    vnoremap <C-Insert> y
	
	    " CTRL-V and SHIFT-Insert are Paste
	    noremap <C-V>      gP
	    noremap <S-Insert> gP
	
	    inoremap <C-V>      <C-R>"
	    inoremap <S-Insert> <C-R>"
	endif
	
	" Pasting blockwise and linewise selections is not possible in Insert and
	" Visual mode without the +virtualedit feature.  They are pasted as if they
	" were characterwise instead.
	" Uses the paste.vim autoload script.
	" Use CTRL-G u to have CTRL-Z only undo the paste.
	
	if has("clipboard")
	    exe 'inoremap <script> <C-V> <C-G>u' . paste#paste_cmd['i']
	    exe 'vnoremap <script> <C-V> ' . paste#paste_cmd['v']
	endif
	
	imap <S-Insert>		<C-V>
	vmap <S-Insert>		<C-V>
	
	" Use CTRL-Q to do what CTRL-V used to do
	noremap <C-Q>		<C-V>
	
	" Use CTRL-S for saving, also in Insert mode (<C-O> doesn't work well when
	" using completions).
	noremap <C-S>		:update<CR>
	vnoremap <C-S>		<C-C>:update<CR>
	inoremap <C-S>		<Esc>:update<CR>gi
	
	" For CTRL-V to work autoselect must be off.
	" On Unix we have two selections, autoselect can be used.
	if !has("unix")
	  set guioptions-=a
	endif
	
	" CTRL-Z is Undo; not in cmdline though
	noremap <C-Z> u
	inoremap <C-Z> <C-O>u
	
	" CTRL-Y is Redo (although not repeat); not in cmdline though
	noremap <C-Y> <C-R>
	inoremap <C-Y> <C-O><C-R>
	
	" Alt-Space is System menu
	if has("gui")
	  noremap <M-Space> :simalt ~<CR>
	  inoremap <M-Space> <C-O>:simalt ~<CR>
	  cnoremap <M-Space> <C-C>:simalt ~<CR>
	endif
	
	" CTRL-A is Select all
	noremap <C-A> gggH<C-O>G
	inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
	cnoremap <C-A> <C-C>gggH<C-O>G
	onoremap <C-A> <C-C>gggH<C-O>G
	snoremap <C-A> <C-C>gggH<C-O>G
	xnoremap <C-A> <C-C>ggVG
	
	" CTRL-Tab is Next window
	noremap <C-Tab> <C-W>w
	inoremap <C-Tab> <C-O><C-W>w
	cnoremap <C-Tab> <C-C><C-W>w
	onoremap <C-Tab> <C-C><C-W>w
	
	" CTRL-F4 is Close window
	noremap <C-F4> <C-W>c
	inoremap <C-F4> <C-O><C-W>c
	cnoremap <C-F4> <C-C><C-W>c
	onoremap <C-F4> <C-C><C-W>c
	
	if has("gui")
	  " CTRL-F is the search dialog
	  noremap  <expr> <C-F> has("gui_running") ? ":promptfind\<CR>" : "/"
	  inoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-O>:promptfind\<CR>" : "\<C-\>\<C-O>/"
	  cnoremap <expr> <C-F> has("gui_running") ? "\<C-\>\<C-C>:promptfind\<CR>" : "\<C-\>\<C-O>/"
	
	  " CTRL-H is the replace dialog,
	  " but in console, it might be backspace, so don't map it there
	  nnoremap <expr> <C-H> has("gui_running") ? ":promptrepl\<CR>" : "\<C-H>"
	  inoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-O>:promptrepl\<CR>" : "\<C-H>"
	  cnoremap <expr> <C-H> has("gui_running") ? "\<C-\>\<C-C>:promptrepl\<CR>" : "\<C-H>"
	endif
	
	" restore 'cpoptions'
	set cpo&
	if 1
	  let &cpoptions = s:save_cpo
	  unlet s:save_cpo
	endif
]]

-- Load evim.vim script to configure a more beginner-friendly GUI experience
-- evim.vim
vim.cmd [[
	" Vim script for Evim key bindings
	" Maintainer:	The Vim Project <https://github.com/vim/vim>
	" Last Change:	2023 Aug 10
	" Former Maintainer:	Bram Moolenaar <Bram@vim.org>
	
	" Don't use Vi-compatible mode.
	set nocompatible
	
	" Use the mswin.vim script for most mappings
	" NVide: Removed since the script is loaded above
	" source <sfile>:p:h/mswin.vim
	
	" Allow for using CTRL-Q in Insert mode to quit Vim.
	inoremap <C-Q> <C-O>:confirm qall<CR>
	
	" Vim is in Insert mode by default
	" NVide: Changed "set insertmode" to "startinsert"
	" set insertmode
	startinsert
	
	" Make a buffer hidden when editing another one
	set hidden
	
	" Make cursor keys ignore wrapping
	inoremap <silent> <Down> <C-R>=pumvisible() ? "\<lt>Down>" : "\<lt>C-O>gj"<CR>
	inoremap <silent> <Up> <C-R>=pumvisible() ? "\<lt>Up>" : "\<lt>C-O>gk"<CR>
	
	" CTRL-F does Find dialog instead of page forward
	noremap <silent> <C-F> :promptfind<CR>
	vnoremap <silent> <C-F> y:promptfind <C-R>"<CR>
	onoremap <silent> <C-F> <C-C>:promptfind<CR>
	inoremap <silent> <C-F> <C-O>:promptfind<CR>
	cnoremap <silent> <C-F> <C-C>:promptfind<CR>
	
	
	set backspace=2		" allow backspacing over everything in insert mode
	set autoindent		" always set autoindenting on
	if has("vms")
	  set nobackup		" do not keep a backup file, use versions instead
	else
	  set backup		" keep a backup file
	endif
	set history=50		" keep 50 lines of command line history
	set ruler		" show the cursor position all the time
	set incsearch		" do incremental searching
	set mouse=a		" always use the mouse
	
	" Don't use Ex mode, use Q for formatting
	map Q gq
	
	" Switch syntax highlighting on, when the terminal has colors
	" Highlight the last used search pattern on the next search command.
	if &t_Co > 2 || has("gui_running")
	  syntax on
	  set hlsearch
	  nohlsearch
	endif
	
	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on
	
	" For all text files set 'textwidth' to 78 characters.
	au FileType text setlocal tw=78
	
	" Add optional packages.
	"
	" The matchit plugin makes the % command work better, but it is not backwards
	" compatible.
	" The ! means the package won't be loaded right away but when plugins are
	" loaded during initialization.
	if has('syntax') && has('eval')
	  packadd! matchit
	endif
	
	" vim: set sw=2 :
]]

-- Prevent leaving Insert Mode except via [Ctrl + E]
_G.nvide_normal_mode = false

-- Always enter Insert Mode when entering a buffer when it's modifiable
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype == '' and vim.bo.modifiable then
      if vim.fn.mode() ~= 'i' then
        vim.cmd 'startinsert'
      end
    else
      if vim.fn.mode() == 'i' then
        vim.cmd 'stopinsert'
      end
    end
  end,
})

-- Enter Normal Mode
vim.keymap.set('i', '<C-E>', function()
  _G.nvide_normal_mode = true
  vim.cmd 'stopinsert'
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  callback = function()
    if vim.fn.mode() == 'n' then
      if not _G.nvide_normal_mode then
        vim.schedule(function()
          vim.cmd 'startinsert'
        end)
      else
        _G.nvide_normal_mode = false
      end
    end
  end,
})



-- Fuzzy finder in current buffer [Ctrl + F]
if Settings['Find']['Enabled'] then
  if pcall(require, 'telescope.builtin') then
    vim.keymap.set({ 'n', 'i' }, Settings['Find']['Shortcut'], function()
      require('telescope.builtin').current_buffer_fuzzy_find {
        attach_mappings = function(_, map)
          map('i', '<CR>', function(prompt_bufnr)
            require('telescope.actions').select_default(prompt_bufnr)
            vim.schedule(function()
              vim.cmd 'startinsert'
            end)
          end)
          return true
        end,
      }
    end, { noremap = true, silent = true })
  end
end



-- Fuzzy finder for files [Ctrl + P]
if Settings['FindFiles']['Enabled'] then
  if pcall(require, 'telescope.builtin') then
    vim.keymap.set({ 'n', 'i' }, Settings['FindFiles']['Shortcut'], function()
      require('telescope.builtin').find_files()
    end, { noremap = true, silent = true })
  end
end



-- Open integrated terminal [Ctrl + T]
if Settings['Terminal']['Enabled'] then
  vim.keymap.set({ 'n', 'i' }, Settings['Terminal']['Shortcut'], function()
    vim.cmd 'split | terminal'
    vim.cmd 'startinsert'
  end, { noremap = true, silent = true })
end



-- Go to line [Ctrl + G]
local function goto_line()
  local was_insert = vim.fn.mode() == 'i'
  if was_insert then
    vim.cmd 'stopinsert'
  end
  vim.ui.input({ prompt = 'Go to line:' }, function(input)
    if input and tonumber(input) then
      vim.cmd(input .. 'G')
    end
    if was_insert then
      vim.cmd 'startinsert'
    end
  end)
end

if Settings['GoToLine']['Enabled'] then
  vim.keymap.set({ 'n', 'i' }, Settings['GoToLine']['Shortcut'], goto_line, { noremap = true, silent = true })
end



-- Move lines up/down with Alt+Up/Down
vim.keymap.set('i', '<M-Up>', '<Esc>:m .-2<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('i', '<M-Down>', '<Esc>:m .+1<CR>==gi', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Up>', ':m .-2<CR>==', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Down>', ':m .+1<CR>==', { noremap = true, silent = true })
vim.keymap.set('v', '<M-Up>', ":move '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set('v', '<M-Down>', ":move '>+1<CR>gv=gv", { noremap = true, silent = true })



-- TODO: Multi-line indentation in Visual Mode [Tab]
-- ...



-- Delete previous word in Insert Mode [Ctrl + Backspace]
vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true })



-- File explorer sidebar [Ctrl + B] (Requires 'neo-tree' plugin)
local function toggle_neotree()
  local was_insert = vim.fn.mode() == 'i'
  if was_insert then
    vim.cmd 'stopinsert'
  end
  vim.cmd 'Neotree toggle'
  if was_insert then
    vim.cmd 'startinsert'
  end
end

if Settings['Sidebar']['Enabled'] then
  vim.keymap.set({ 'n', 'i' }, Settings['Sidebar']['Shortcut'], toggle_neotree, { noremap = true, silent = true })
end
