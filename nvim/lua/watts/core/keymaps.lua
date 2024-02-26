vim.g.mapleader = " "

local set = vim.keymap.set

-- TODO: Research what noremap and silent do, and if I *really* need them
local opts = { noremap = true, silent = true }

-- Map JJ to escape
set("i", "jj", "<ESC>")

-- Toggle Paste mode
set("n", "<F6>", ":set paste!")

-- Clear out highlights
set("n", "<F7>", ":nohl<CR>")

-- Toggle back/forth between to previous file
set("n", "<leader><leader>", "<c-^>")

-- Deleting single characters, but doesn't copy into register
set("n", "x", '"_x')

-- Incrementing and decrementing numbers
set("n", "+", "<C-a>")
set("n", "-", "<C-x>")

-- Window management
set("n", "<leader>v", "<C-w>v")     -- vertical split
set("n", "<leader>h", "<C-w>s")     -- horizontal split
set("n", "<leader>e", "<C-w>=")     -- make splits same size
set("n", "<leader>x", ":close<CR>") -- close current split

-- Tab management
set("n", "<leader>t", ":tabnew<CR>")   -- open a new tab
set("n", "<leader>w", ":tabclose<CR>") -- close the current tab
set("n", "<leader>]", ":tabn<CR>")     -- next tab
set("n", "<leader>[", ":tabp<CR>")     -- previous tab

-- Mappings for Moving Lines
-- Normal mode, moving current line
set("n", "<S-k>", ":m-2<CR>", opts)         -- up
set("n", "<S-j>", ":m+<CR>", opts)          -- down
-- Visual mode, selected text
set("v", "<S-j>", ":m '>+1<CR>gv=gv", opts) -- up
set("v", "<S-k>", ":m '<-2<CR>gv=gv", opts) -- down

-- Quickfix List Navigation
-- what other options are there for this, other than ]q and [q
set("n", "<C-[>", ":cprev<CR>", opts)
set("n", "<C-]>", ":cnext<CR>", opts)
