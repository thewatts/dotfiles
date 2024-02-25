vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Map JJ to escape
keymap.set("i", "jj", "<ESC>")

-- Toggle Paste mode
keymap.set("n", "<F6>", ":set paste!")

-- Clear out highlights
keymap.set("n", "<F7>", ":nohl<CR>")

-- Toggle back/forth between to previous file
keymap.set("n", "<leader><leader>", "<c-^>")

-- Deleting single characters, but doesn't copy into register
keymap.set("n", "x", '"_x')

-- Incrementing and decrementing numbers
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Window management
keymap.set("n", "<leader>v", "<C-w>v")     -- vertical split
keymap.set("n", "<leader>h", "<C-w>s")     -- horizontal split
keymap.set("n", "<leader>e", "<C-w>=")     -- make splits same size
keymap.set("n", "<leader>x", ":close<CR>") -- close current split

-- Tab management
keymap.set("n", "<leader>t", ":tabnew<CR>")   -- open a new tab
keymap.set("n", "<leader>w", ":tabclose<CR>") -- close the current tab
keymap.set("n", "<leader>]", ":tabn<CR>")     -- next tab
keymap.set("n", "<leader>[", ":tabp<CR>")     -- previous tab

-- Mappings for Moving Lines
-- Normal mode, moving current line
keymap.set("n", "<S-k>", ":m-2<CR>", opts) -- up
keymap.set("n", "<S-j>", ":m+<CR>", opts) -- down
-- Visual mode, selected text
keymap.set("v", "<S-j>", ":m '>+1<CR>gv=gv", opts) -- up
keymap.set("v", "<S-k>", ":m '<-2<CR>gv=gv", opts) -- down

-- Quickfix List Navigation
-- what other options are there for this, other than ]q and [q
keymap.set("n", "<C-[>", ":cprev<CR>", opts)
keymap.set("n", "<C-]>", ":cnext<CR>", opts)
