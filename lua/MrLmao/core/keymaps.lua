vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps

keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>")

keymap.set("n", "x", '"_x"')

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split windew horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split window equal size
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split widow

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- vim navigation
keymap.set("n", "˙", ":TmuxNavigateLeft<CR>")
keymap.set("n", "∆", "<cmd>TmuxNavigateDown<cr>")
keymap.set("n", "˚", "<cmd>TmuxNavigateUp<cr>")
keymap.set("n", "¬", "<cmd>TmuxNavigateRight<cr>")
keymap.set("n", "«", "<cmd>TmuxNavigatePrevious<cr>")

-- plugin keymaps
--
-- vim-macimizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", ":<cmd>Telescope find_files<cr>")
keymap.set("n", "<leader>fs", ":<cmd>Telescope line_grep<cr>")
keymap.set("n", "<leader>fc", ":<cmd>Telescope grep_string<cr>")
keymap.set("n", "<leader>fb", ":<cmd>Telescope buffers<cr>")
keymap.set("n", "<leader>fh", ":<cmd>Telescope help_tags<cr>")

-- Keymaps for inserting multiple lines below
keymap.set("n", "2o", "o<Esc>o", { noremap = true, silent = true })
keymap.set("n", "3o", "o<Esc>o<Esc>o", { noremap = true, silent = true })
keymap.set("n", "4o", "o<Esc>o<Esc>o<Esc>o", { noremap = true, silent = true })
keymap.set("n", "5o", "o<Esc>o<Esc>o<Esc>o<Esc>o", { noremap = true, silent = true })

-- Keymaps for inserting multiple lines above
keymap.set("n", "2O", "O<Esc>O", { noremap = true, silent = true })
keymap.set("n", "3O", "O<Esc>O<Esc>O", { noremap = true, silent = true })
keymap.set("n", "4O", "O<Esc>O<Esc>O<Esc>O", { noremap = true, silent = true })
keymap.set("n", "5O", "O<Esc>O<Esc>O<Esc>O<Esc>O", { noremap = true, silent = true })

-- for page scrolling
keymap.set("n", "ƒ", "<C-f>", { noremap = true, silent = true })
keymap.set("n", "∫", "<C-b>", { noremap = true, silent = true })

keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true }) -- move to next buffer
keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true }) -- move to previous buffer
keymap.set("n", "<leader>bx", ":bd<CR>", { noremap = true, silent = true }) -- kill current buffer
