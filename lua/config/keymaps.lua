-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Void register shortcuts
vim.keymap.set({ "n", "v", "o" }, "|", '"_', { noremap = true, desc = "Use void register" })
vim.keymap.set({ "v" }, "|p", '"_dp', { noremap = true, desc = "Paste over without yanking" })
vim.keymap.set({ "v" }, "|p", '"_dP', { noremap = true, desc = "Paste over without yanking" })

-- Delete single character without copying into register
vim.keymap.set("n", "x", '"_x', { desc = "Delete char without yanking" })

-- HOME and END
local function smart_home()
  -- Toggle between ^ and 0
  local col = vim.fn.col(".")
  local first_nonblank = vim.fn.match(vim.fn.getline("."), "\\S") + 1

  if col == first_nonblank then
    -- Already at first non-blank, go to column 0
    return "0"
  else
    -- Go to first non-blank
    return "^"
  end
end

vim.keymap.del("n", "H")
vim.keymap.del("n", "L")
vim.keymap.set({ "n", "x", "o" }, "H", smart_home, { expr = true, desc = "Beginning of line (progressively)" })
vim.keymap.set({ "n", "x", "o" }, "L", "$", { desc = "End of line" })

-- Buffer line navigation
vim.keymap.set("n", "<C-]>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" }) -- same as `[b`
vim.keymap.set("n", "<C-[>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" }) -- same as `]b`
-- having trouble making <C-{> and <C-}> work. Default `[B` and `]B` should be enough

-- Center screen after scrolling up/down half a screen
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and then center the cursorline" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and then center the cursorline" })

-- Add centering the cursorline after fold ops
vim.keymap.set("n", "zo", "zozz", { desc = "Open fold under cursor" })
vim.keymap.set("n", "zO", "zOzz", { desc = "Open all folds under cursor" })
vim.keymap.set("n", "zR", "zRzz", { desc = "Open all folds" })

vim.keymap.set("n", "zc", "zczz", { desc = "Close fold under cursor" })
vim.keymap.set("n", "zC", "zCzz", { desc = "Close all folds under cursor" })
vim.keymap.set("n", "zM", "zMzz", { desc = "Close all folds" })

vim.keymap.set("n", "zr", "zrzz", { desc = "Fold less" })
vim.keymap.set("n", "zm", "zmzz", { desc = "Fold more" })

vim.keymap.set("n", "n", "nzz", { desc = "move to the next search match and then center the cursorline" })
vim.keymap.set("n", "N", "Nzz", { desc = "move to the prev search match and then center the cursorline" })

-- Restart LSP server if necessary
vim.keymap.set("n", "<leader>xR", ":LspRestart<CR>", { desc = "Restart LSP server" })

-- Select all
vim.keymap.set({ "n", "x", "o", "v" }, "<M-a>", "<Cmd>normal! ggVG<CR>", { desc = "Select all" })

-- Trouble
vim.keymap.set("n", "<leader>cS", function()
  vim.cmd("Trouble lsp win.position=bottom focus=true")
  vim.defer_fn(function()
    vim.cmd("resize +15")
  end, 250)
end, { desc = "LSP references/defs/... (Trouble)" })

vim.keymap.set({ "n" }, "<leader>WH>", "<Cmd>vertical resize -2<CR>", { desc = "Vertical resize window - narrower" })
vim.keymap.set({ "n" }, "<leader>WH>", "<Cmd>vertical resize 2<CR>", { desc = "Vertical resize window - wider" })
vim.keymap.set({ "n" }, "<leader>WJ>", "<Cmd>resize -2<CR>", { desc = "Horizontal resize window - shorter" })
vim.keymap.set({ "n" }, "<leader>WK>", "<Cmd>resize 2<CR>", { desc = "Horizontal resize window - taller" })
